Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131922AbQL3B1C>; Fri, 29 Dec 2000 20:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132135AbQL3B0w>; Fri, 29 Dec 2000 20:26:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:44041 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131922AbQL3B0s>; Fri, 29 Dec 2000 20:26:48 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dave Gilbert <gilbertd@treblig.org>
Date: Sat, 30 Dec 2000 11:56:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14925.12964.995179.63899@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
In-Reply-To: message from Dave Gilbert on Friday December 29
In-Reply-To: <14924.64601.485759.167765@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.10.10012292252450.26235-100000@tardis.home.dave>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 29, gilbertd@treblig.org wrote:
> On Sat, 30 Dec 2000, Neil Brown wrote:
> 
> > > So where did the gilbertd directory go ?

It suffered the curse of the 8-character file name....

> > 
> > Can you get a tcpdump (-s 1024) of the network traffic while this is
> > happening?
> 
> Yep; to avoid posting to the list I've put it at:
> http://www.treblig.org/nfs_bug_netlog
> 
> its 14K and is the output of:
> 
>  /usr/sbin/tcpdump -vv -x -s 1024 host sol and tardis > /tmp/netlog 2>&1
> 

Well......
The trace contains a number of lookup requests.
For example, there is a lookup of "samba" which contains the
encoded file name:

0000 0005 7361 6d62 6100
          s a  m b  a

The "0000 0005" is the file name length.
The corresponding part of the lookup request for gilbertd looks like:

6572 7464 6572 7464 0072 7464
e r  t d  e r  t d    r  t d

Note there is no leading length count.  This is not actually
surprising when you look at  
  net/sunrpc/xdr.c:xdr_decode_string

If the length of the string is a multiple of 4, there is no spare
following byte to be a nul terminator for the string, so the whole
string is copied back 4 bytes using memmove.  This change takes place
in the actual packet in the network buffer which is why tcpdump sees
it's effect.  But you would expect to see:

6769 6c62 6572 7464 0072 7464
g i  l b  e r  t d    r  t d

but you don't.  Why?

My only guess is that memmove is doing the wrong thing, and moving
from the end of the string instead of from the start.
What architecture are you doing this on? Your signature lists 4!:-)

Could you
  gdb vmlinux
  disassemble xdr_decode_string
  disassemble memmove

and see if the code looks right?

You might like to try:

 1/ move gilbertd to gilbertdd and see if you can then access it over
    nfs.
 2/ create a file called "ertdertd" and see if you get that when you
    try to access gilbertd

> Thanks,
> 
> Dave
> 
> -- 
>  ---------------- Have a happy GNU millennium! ----------------------   
> / Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
> \   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
>  \ ___________________________|___ http://www.treblig.org  |________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
