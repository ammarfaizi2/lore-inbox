Return-Path: <linux-kernel-owner+w=401wt.eu-S1750903AbXAEXyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXAEXyF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXAEXyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:54:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:56354 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXAEXyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:54:03 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Finding hardlinks
To: Miklos Szeredi <miklos@szeredi.hu>, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org, pavel@ucw.cz
Reply-To: 7eggert@gmx.de
Date: Sat, 06 Jan 2007 00:54:28 +0100
References: <7x5mR-2wX-3@gated-at.bofh.it> <7x9Ad-18O-35@gated-at.bofh.it> <7yXEy-UI-39@gated-at.bofh.it> <7yYKa-2Ds-3@gated-at.bofh.it> <7zcWP-7ET-5@gated-at.bofh.it> <7zdzA-jc-27@gated-at.bofh.it> <7zeP5-2ic-15@gated-at.bofh.it> <7zgH9-5my-17@gated-at.bofh.it> <7zJSM-14t-9@gated-at.bofh.it> <7zSW5-6cj-9@gated-at.bofh.it> <7zX9l-4rS-7@gated-at.bofh.it> <7zXMb-5g5-27@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H2ytI-0000p2-Qg@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

>> > Well, sort of.  Samefile without keeping fds open doesn't have any
>> > protection against the tree changing underneath between first
>> > registering a file and later opening it.  The inode number is more
>> 
>> You only need to keep one-file-per-hardlink-group open during final
>> verification, checking that inode hashing produced reasonable results.
> 
> What final verification?  I wasn't just talking about 'tar' but all
> cases where st_ino might be used to check the identity of two files at
> possibly different points in time.
> 
> Time A:    remember identity of file X
> Time B:    check if identity of file Y matches that of file X
> 
> With samefile() if you open X at A, and keep it open till B, you can
> accumulate large numbers of open files and the application can fail.
> 
> If you don't keep an open file, just remember the path, then renaming
> X will foil the later identity check.  Changing the file at this path
> between A and B can even give you a false positive.  This applies to
> 'tar' as well as the other uses.

If you open Y, this open file descriptor will guarantee that no distinct
file will have the same inode number while all hardliked files must have
the same inode number. (AFAIK)

Now you will check this against the list of hardlink candidates using the
stored inode number. If the inode number has changed, this will result in
a false negative. If you removed X, recreated it with the same inode number
and linked that to Y, you'll get a false positive (which could be identified
by the [mc]time changes).

Samefile without keeping the files open will result in the same false
positive as open+fstat+stat, while samefile with keeping the files open
will occasionally overflow the files table, Therefore I think it's not
worth while introducing samefile as long as the inode is unique for open
files. OTOH you'll want to keep the inode number as stable as possible,
since it's the only sane way to find sets of hardlinked files and some
important programs may depend on it.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
