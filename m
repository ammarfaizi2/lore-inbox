Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUEUBOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUEUBOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 21:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265318AbUEUBOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 21:14:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26305 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265301AbUEUBOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 21:14:17 -0400
Date: Fri, 21 May 2004 02:14:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: sfrench@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: [WTF] CIFS bugs galore
Message-ID: <20040521011416.GQ17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh...  Observations from reading fs/cifs at random places:

fs/cifs/dir.c::build_path_from_dentry() goes from dentry to fs root
counting path length.  Then it does kmalloc().  Then it proceeds
to build said path in the buffer it had just allocated.
Could you spell "rename"?  Good.  Could you spell "user-triggerable
buffer overrun in kernel mode with user-controlled contents"?

Incidentally,
        namelen += 1;           /* allow for trailing null */
        full_path = kmalloc(namelen, GFP_KERNEL);
        namelen--;
        full_path[namelen] = 0; /* trailing null */
is generally considered a Bad Idea(tm).

While we are at it, what exactly would happen if I do lookup on a\\b?
AFAICS, there is no place that would reject such names - build_...
certainly will _not_ do that.  What's more, it will give exactly the
same as it would produce on a/b.

Speaking of which, what exactly happens if rename() happens between
the time when we build the pathname and time when we send it to
server?  Or if file had been e.g. unlinked or renamed over since
it had been opened...

BTW, what the hell is your ->open() doing checking if ->private_data
is non-NULL?  It's called only once in struct file lifetime; the thing
had been allocated just before the call.

Similar in ->write() -
                                if((file->f_dentry == NULL) || (file->f_dentry->d_inode == NULL)) {
is 100% bogus - if it ever happens, we are screwed big way and BUG() is the
best you could do.  Same for
        /* since the write may have blocked check these pointers again */
        if(file->f_dentry) {
                if(file->f_dentry->d_inode) {
WTF does that have to something getting blocked? (and again, never happens)

In cifs_partialpagewrite() you have
        struct address_space *mapping = page->mapping;
        struct inode *inode = page->mapping->host;
        if (!mapping) {
                return -EFAULT;
        } else if(!mapping->host) {
                return -EFAULT;
        }
which makes no fscking sense at all, for the obvious reasons.

BTW, I really wonder if you can read the fragments like
                                        if (Unicode == TRUE)
                                                pfindData->FileNameLength =
                                                    cifs_strfromUCS_le
                                                    (pfindData->FileName,
                                                     (wchar_t *)
                                                     pfindData->FileName,
                                                     (pfindData->
                                                      FileNameLength) / 2,
                                                     cifs_sb->local_nls);
                                        qstring.len = pfindData->FileNameLength;
                                        if (((qstring.len != 1)
                                             || (pfindData->FileName[0] != '.'))
                                            && ((qstring.len != 2)
                                                || (pfindData->
                                                    FileName[0] != '.')
                                                || (pfindData->
                                                    FileName[1] != '.'))) {
                                                if(cifs_filldir(&qstring,
                                                             pfindData,
                                                             file, filldir,
                                                             direntry)) {
                                                        /* do not end search if
                                                                kernel not ready to take
                                                                remaining entries yet */
                                                        reset_resume_key(file, pfindData->FileName,qstring.len,
                                                                Unicode, cifs_sb->local_nls);
                                                        findParms.EndofSearch = 0;
                                                        break;
                                                }
... that, but most of us mere mortals can not.

Folks, 'fess up - had anybody ever reviewed that code and how did it end up
merged into the tree?
