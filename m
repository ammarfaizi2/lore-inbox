Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTBKQqG>; Tue, 11 Feb 2003 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTBKQqG>; Tue, 11 Feb 2003 11:46:06 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:9709 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267322AbTBKQqD>; Tue, 11 Feb 2003 11:46:03 -0500
Message-ID: <3E492B0D.4020004@blue-labs.org>
Date: Tue, 11 Feb 2003 11:55:41 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Current NFS issues (2.5.59)
References: <3E46E1D6.20709@blue-labs.org> <15944.30340.955911.798377@notabene.cse.unsw.edu.au>
In-Reply-To: <15944.30340.955911.798377@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Sunday February 9, david+powerix@blue-labs.org wrote:
>  
>
>>Ok.  Here goes.  I have two servers that NFS mount from each other and 
>>provide.
>>    
>>
>
>Thankyou for using the development kernel and sharing your woes...
>

heheheh...

>>Server 1 exports A, B, and C to server 2.  Server 2 exports D and E back 
>>to server 1 and exports F and G to two other clients.  Each of these 
>>(A-G) are distinctly different filesystem paths and not part of each other.
>>
>>1. If server 1 is restarted, server 2 will invalidate (make all 'df' 
>>values '1') F and G.  This requires an 'exportfs -vra' or similar on 
>>server 2 to fix the client 'df' values.  The client doesn't need to do 
>>anything.
>>    
>>
>
>This has me completely mystified.  If I understand correctly, an event
>on server 1 causes a failure to commuinicate between server 2 and some
>third party..
>
>I can only imagine that as server 1 boots it does something to server
>2.  At the very least it sends a mount request for D and E.  I'm not
>sure how a mount request for D or E would affect F or G.
>Are you using an automounter at all?
>

No, no automount of any sort.  Server 1 and server 2 share /home and 
apache virtuals back and forth, shell and web server.  So they are 
mounted at boot.

Server 1 is the shell server, 2 is the web server.  When the shell 
server is restarted, all the clients that fetch other mounts off the web 
server get '1's for the df information in short order.  There is some 
delay, not sure what the delay is for.  During that delay, 
/nfsmountpoint access stalls on the clients.  Unfortunately my own home 
directory comes off that mountpoint and the wonder coding of Raster 
causes multiple large explosions and instantaneous destruction of your 
graphical session.  So I've lost a fair amount of NFS debug notes 
unexpectedly :S

If I'm fast on the draw and run exportfs on server 2 quick enough, I 
manage to save my desktop before that timeout hits.

>>2. Repeated nfs system stops and starts (/etc/init.d/nfs restart) will 
>>eventually cause a kernel panic on server 2 (haven't tested on server 
>>1).   The number of restarts is variable.
>>    
>>
>
>Can you capture the panic and send it to me please?
>

I plan to setup a notebook w/ serial console capture.

>>3. Mount point F (/home/david) infrequently loops.  ls -la /home/david 
>>will loop forever until all client memory is exhausted and the kernel 
>>kills it via OOM.  ls -la /home/david/somefile or /home/david/somedir/ 
>>works just fine as well as any sub directory under /home/david.  
>>Restarts of both systems refuse to fix things.
>>    
>>
>
>I think this might be a reiserfs problem.  Someone else mentioned that
>this started happening when they upgrade from an earlier 2.5 kernel.
>If you can capture the NFS traffic 
>	tcpdump -s 1500 -w /tmp/afile host $server and host $client
>we could have a look at the directory cookies and see what is
>happening.
>

Is this important to start the tcpdump before the mount is established?  
If I start the tcpdump after I've detected the looping, is that useful?  
There's a lot of NFS traffic :)

Another thing that I've noted, it looks like a corrupt ->next ring 
pointer.  [example only] Given 500 directory entries, at some random 
ring index, 50 of those entries start looping.  say it was 100-150.  A 
few hours later it might be 350-400.  The previous entries would scroll 
by then that 50 would start looping.  That 50 is the same 50 that will 
loop even after both machines have been rebooted.

The looping only seems to happen when something abnormal happens on the 
mountpoint or the system is rebooted.  I.e. enlightenment fubars when 
you try to edit a menu and the entire desktop blows up as usual.  That 
has a small probability of starting a loop effect.  I've had that once.  
At all other times, the looping happens immediately after bootup.

As a reminder, only globbed access to the top level mountpoint see the 
looping.  Any single entry access or sub level access is fine.  ls -l 
/nfsmount fails.  ls -l /nfsmount/a* fails but ls -dl 
/nfsmount/file_or_dir works fine, as well as ls -l 
/nfsmount/anything_below/this/


>>4. Mounts infrequently get "permission denied" messages on the client 
>>with a " rpc.mountd: getfh failed: Operation not permitted" message on 
>>the server.  This is fixable by restarting the nfs system on the server.
>>
>>    
>>
>
>I've seen this, but it was fixed by the time 2.5.59 came out.
>If/when it happens again, could you please check if the IP address of
>the client in question is in
>    /proc/net/rpc/auth.unix.ip/content
>and if the name found there is in
>    /proc/fs/nfs/exports
>next to the appropriate filesystem.
>
>NeilBrown
>

Will do.  I saw it every time when I booted into 2.5.53 and again when 
booting back.  If I reboot with the same kernel version, it's normally 
fine.  However it does happen too often with both systems being 2.5.59.

David


