Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129990AbQLBRL6>; Sat, 2 Dec 2000 12:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbQLBRLq>; Sat, 2 Dec 2000 12:11:46 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:10756 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129990AbQLBRL2>;
	Sat, 2 Dec 2000 12:11:28 -0500
Date: Sat, 2 Dec 2000 17:39:59 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001202173959.A10166@vana.vc.cvut.cz>
In-Reply-To: <3A29008E.F05E5C95@uow.edu.au> <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 02, 2000 at 10:33:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 10:33:36AM -0500, Alexander Viro wrote:
> On Sun, 3 Dec 2000, Andrew Morton wrote:
> 
> > It appears that this problem is not fixed.
> 
> Sure, it isn't. Place where the shit hits the fan: fs/buffer.c::unmap_buffer().
> Add the call of remove_inode_queue(bh) there and see if it helps. I.e.
> 
> ed fs/buffer.c <<EOF
> /unmap_buffer/
> /}/i
> 		remove_inode_queue(bh);
> .
> wq
> EOF
> 
> Linus, could you apply that? We are leaving the unmapped buffers on the
> inode queue. I.e. every truncate_inode_pages() leaves a lot of junk around.
> Now, guess what happens when we destroy the last link to inode that nobody
> keeps open...

Nothing new (was it meant to run remove_inode_queue() conditionaly inside 
buffer_mapped() branch? ed did it that way). First is list of buffers at 
time of destroy_inode, then process. If you want full oops trace, it is 
available at http://platan.vc.cvut.cz/oops3.txt, but last part is always 
iput. For now I'm back on test9, as I lost inetd.conf again :-( Someone 
should shoot sendmail Debian maintainer... Running update-inetd at startup 
is really bad idea, as fsck then usually removes both old and new inetd.conf, 
so I'm back on inetd.conf from 25 Aug 1999 :-(((

Fields printed from buffer_head are b_next, b_blocknr, b_size, b_list,
b_count, b_state and b_inode. (oops now I see that I left
remove_inode_queue(bh) in printing loop (I copied it from
invalidate_inode_buffers()), but it should not hurt, I believe. Dirty buffers
should find its way to disk anyway, or not?)
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

BTW, running 'ksymoops < oops > oops.txt' is great source of errors below,
as it (probably) uses couple of unlinked temorary files...

next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7bf3ce0

Process mount (pid: 30, stackpage=c7df3000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7bf3ce0

Process mount (pid: 31, stackpage=c7df3000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7c1a860

Process mount (pid: 68, stackpage=c7997000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7b54c80

Process mount (pid: 70, stackpage=c7997000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7b54c80

Process mount (pid: 70, stackpage=c7997000)


next=00000000, nr=3375109, size=4096, list=2
count=0
state=0000001B inode=c77e2260

Process rm (pid: 82, stackpage=c7b35000)


next=00000000, nr=3506180, size=4096, list=2
count=0
state=0000001B inode=c77eb9c0

Process rm (pid: 121, stackpage=c776d000)

next=00000000, nr=3506180, size=4096, list=2
count=0
state=0000001B inode=c77ebb40
next=00000000, nr=3507147, size=4096, list=2
count=0
state=0000001B inode=c77ebb40

Process rm (pid: 122, stackpage=c776d000)


next=00000000, nr=1179657, size=4096, list=2
count=0
state=0000001B inode=c77ebb40

Process rm (pid: 123, stackpage=c776d000)


next=00000000, nr=294919, size=4096, list=2
count=0
state=0000001B inode=c77eb240

Process rm (pid: 129, stackpage=c775d000)


next=00000000, nr=294919, size=4096, list=2
count=0
state=0000001B inode=c77eb0c0

Process rm (pid: 130, stackpage=c775d000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7889c60

Process mv (pid: 138, stackpage=c7985000)


next=c796fce0, nr=294916, size=4096, list=2
count=0
state=0000001B inode=c77eb6c0

Process rm (pid: 142, stackpage=c7721000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c75e83a0

Process update-inetd (pid: 273, stackpage=c715d000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7b359a0

Process rm (pid: 305, stackpage=c6b33000)


next=00000000, nr=2457654, size=4096, list=2
count=0
state=0000001B inode=c7b356a0

Process rm (pid: 305, stackpage=c6b33000)


next=c6ed8980, nr=753674, size=4096, list=2
count=0
state=0000001B inode=c655a3a0

Process mc (pid: 330, stackpage=c6703000)


next=00000000, nr=196617, size=4096, list=2
count=0
state=0000001B inode=c656c4e0

Process mc (pid: 330, stackpage=c6703000)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
