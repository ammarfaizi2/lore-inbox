Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTBKDz5>; Mon, 10 Feb 2003 22:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTBKDz4>; Mon, 10 Feb 2003 22:55:56 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:46741 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265872AbTBKDzz>; Mon, 10 Feb 2003 22:55:55 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Ford <david+powerix@blue-labs.org>
Date: Tue, 11 Feb 2003 15:05:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15944.30340.955911.798377@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Current NFS issues (2.5.59)
In-Reply-To: message from David Ford on Sunday February 9
References: <3E46E1D6.20709@blue-labs.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 9, david+powerix@blue-labs.org wrote:
> Ok.  Here goes.  I have two servers that NFS mount from each other and 
> provide.

Thankyou for using the development kernel and sharing your woes...

> 
> Server 1 exports A, B, and C to server 2.  Server 2 exports D and E back 
> to server 1 and exports F and G to two other clients.  Each of these 
> (A-G) are distinctly different filesystem paths and not part of each other.
> 
> 1. If server 1 is restarted, server 2 will invalidate (make all 'df' 
> values '1') F and G.  This requires an 'exportfs -vra' or similar on 
> server 2 to fix the client 'df' values.  The client doesn't need to do 
> anything.

This has me completely mystified.  If I understand correctly, an event
on server 1 causes a failure to commuinicate between server 2 and some
third party..

I can only imagine that as server 1 boots it does something to server
2.  At the very least it sends a mount request for D and E.  I'm not
sure how a mount request for D or E would affect F or G.
Are you using an automounter at all?

> 
> 2. Repeated nfs system stops and starts (/etc/init.d/nfs restart) will 
> eventually cause a kernel panic on server 2 (haven't tested on server 
> 1).   The number of restarts is variable.

Can you capture the panic and send it to me please?


> 
> 3. Mount point F (/home/david) infrequently loops.  ls -la /home/david 
> will loop forever until all client memory is exhausted and the kernel 
> kills it via OOM.  ls -la /home/david/somefile or /home/david/somedir/ 
> works just fine as well as any sub directory under /home/david.  
> Restarts of both systems refuse to fix things.

I think this might be a reiserfs problem.  Someone else mentioned that
this started happening when they upgrade from an earlier 2.5 kernel.
If you can capture the NFS traffic 
	tcpdump -s 1500 -w /tmp/afile host $server and host $client
we could have a look at the directory cookies and see what is
happening.

> 
> 4. Mounts infrequently get "permission denied" messages on the client 
> with a " rpc.mountd: getfh failed: Operation not permitted" message on 
> the server.  This is fixable by restarting the nfs system on the server.
> 

I've seen this, but it was fixed by the time 2.5.59 came out.
If/when it happens again, could you please check if the IP address of
the client in question is in
    /proc/net/rpc/auth.unix.ip/content
and if the name found there is in
    /proc/fs/nfs/exports
next to the appropriate filesystem.

NeilBrown
