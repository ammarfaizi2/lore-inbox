Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130405AbRAPVa7>; Tue, 16 Jan 2001 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAPVat>; Tue, 16 Jan 2001 16:30:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:18184 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129561AbRAPVak>;
	Tue, 16 Jan 2001 16:30:40 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Tue, 16 Jan 2001 22:29:30 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
CC: <linux-kernel@vger.kernel.org>, <rmager@vgkk.com>
X-mailer: Pegasus Mail v3.40
Message-ID: <12C574CB1236@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 01 at 21:17, Urban Widmark wrote:
> The smbfs dircache needs to find/kmap all of its cache pages since the
> entries in it are variable length and the way it is called. It would be
> nice to change that.
> 
> I haven't looked at all your detailed comments yet. They may not matter if
> the many kmaps are a problem.

I think that too many kmaps could explain reported 'silent hang'... (if
my memory serves good, there was some report about silent PAE hang during
last 7 days, yes?). Not-checking ->block for NULL looks like bug which
can be triggered without kmap too.
 
> how can it know that the dentry is the right one? I thought that dentries
> could be removed/reused by someone at will (d_count will be 0 because of
> the dput in ncp_fill_cache, no?). Why isn't it possible for someone to
> write a new dentry where the old one was.
> 
> fs/ncpfs/dir.c:ncp_d_validate() calls
>   valid = d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);
> 
> all values are taken from the dentry pointer on the cache page (including
> len). d_validate verifies that d_hash() points to a list and it searches
> the list for dentry. How do you know that it is the same dentry that was
> put in the cache and not someone elses dentry?

Before calling d_validate it checks whethern dentry->d_parent == parent
(readdir-ed directory). And if dentry is in directory we read,
it is in dentry d_hash, and even d_fsdata matches its position in
directory, I bet that it is valid dentry... 

If there is new dentry, which is at fpos postion, and it is child of
readdir-ed directory, we should return it anyway, no? There must not be
two ncpfs dentries with same d_parent and d_fsdata if d_fsdata != 0,
as each dentry can be in only one directory.

This looked as reasonable limitation to me ;-)
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
