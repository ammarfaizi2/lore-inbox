Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTKJElL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTKJElL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:41:11 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26292 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262882AbTKJElI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:41:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 10 Nov 2003 15:36:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16303.5603.756320.254335@www.kingsfordchurch.org.au>
Cc: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       <Linux-kernel@vger.kernel.org>
Subject: Re: slab corruption in test9 (NFS related?)
In-Reply-To: message from Linus Torvalds on Sunday November 9
References: <16303.131.838605.661991@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 9, torvalds@osdl.org wrote:
> 
> On Mon, 10 Nov 2003, Neil Brown wrote:
> >
> > An extra dput was introduced in nfsd_rename 20 months ago....
> > 
> > time to remove it.
> 
> Oh, you stand-up comedian you.
> 
> I'm just wondering how the hell this hasn't bit us seriously until now?  
> What's up?
> 
> In other words, your patch certainly looks obviously correct, but it also
> looks _so_ obviously correct that my alarm bells are going off. If the
> code was quite that broken at counting dentries, how the hell did it ever
> work AT ALL?
> 
> Call me suspicious, but I find this really strange..
> 
> 		Linus

Me too.
I had to read through the code several times, and then find the patch
that introduced the bug and make sure it looked wrong too, which it
does.

The only time that the dentry is used after the dput that reduces
d_count to 0, is that dput is called once more, and it is very soon
and only decrements the count (down to -1).
So there is a very small window for someone else to get that piece of
memory and have it corrupted.

This bug was first brought to my attention by the NFSv4 team who have
obviously been hammering nfsd harder than the rest of us (an in more
interesting ways, as is the nature of nfsv4).

NeilBrown
