Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSK0AeM>; Tue, 26 Nov 2002 19:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSK0AeM>; Tue, 26 Nov 2002 19:34:12 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:55011 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S263837AbSK0AeJ>; Tue, 26 Nov 2002 19:34:09 -0500
Date: Tue, 26 Nov 2002 22:41:23 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021126224123.A9660@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no> <20021120120223.A15034@blackjesus.async.com.br> <15835.49194.109931.227732@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15835.49194.109931.227732@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 20, 2002 at 06:02:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 06:02:34PM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > I haven't forgotten this. It's just that I've been unable to
>      > test: the problem just stopped showing up when I upgraded to
>      > 2.4.20-pre11 with your NFS-ALL patches applied to it. Could
>      > something have changed, or are we just lucky?
> 
> The main changes have been the discovery of a couple of kmap()
> imbalances. Those are also fixed in 2.4.20-rc2.

Just because I send that email my server decided it is going to act up
again. So this time I sat down, and looked hard at the logs and tcpdump
output and this is what I *think*: a lockd bug. Here's the symptoms:

(recalling, a 100mbps network on a d-link switch with about 10 diskless
clients. Some of the boxes start getting really slow shutdown and
startup, and the server seems to be unaffected. Clients run 2.4.19 with
trond's-ALL patches, server runs 2.4.20-pre11 with trond's-ALL patches.
everything *should* be tcp-mounted, but I'm not 100% sure about the root
filesystem)

Trond, I've attached quite a bit of debug output below, but I'm a bit
lost as to what it could be now. Do you think I should start suspecting
the hardware, now? I have *no* reason to do so, but if nobody else sees
this sort of issue...

a) ps ax | grep lockd returns:

   94 ?        DW     0:00 [lockd]

    Why would lockd be in state "D"? Looks bad. Can this happen in
    normal usage? It kicks the loadavg up 1 point.

b) tcpdump output, as seen by the server, during bootup (server is
anthem, violinux is client):

    [seemingly normal nfs operation up to here]

    09:24:08.876333 anthem.async.com.br.nfs > violinux.async.com.br.2153135585: reply ok 128 lookup [|nfs] (DF)
    09:24:08.876464 violinux.async.com.br.2169912801 > anthem.async.com.br.nfs: 132 setattr [|nfs] (DF)
    09:24:08.876490 anthem.async.com.br.nfs > violinux.async.com.br.2169912801: reply ok 96 setattr [|nfs] (DF)

    [ 10-second delay here ]

    09:24:18.988289 violinux.async.com.br.793 > anthem.async.com.br.sometimes-rpc4: udp 180 (DF)

    [ 11-second delay here ]

    09:24:29.889685 violinux.async.com.br.2891398625 > anthem.async.com.br.nfs: 116 lookup [|nfs] (DF)
    09:24:29.889864 anthem.async.com.br.nfs > violinux.async.com.br.2891398625: reply ok 128 lookup [|nfs] (DF)
    09:24:29.890121 violinux.async.com.br.2908175841 > anthem.async.com.br.nfs: 112 read [|nfs] (DF)
    09:24:29.890245 anthem.async.com.br.nfs > violinux.async.com.br.2908175841: reply ok 720 read [|nfs] (DF)
    09:24:29.890654 violinux.async.com.br.2924953057 > anthem.async.com.br.nfs: 116 lookup [|nfs] (DF)

    [ back to business as usual ]

This repeats itself a number of times, and these 20-second combined
hangs take their toll - it's 10 minutes already and no bootup. The
slowness does *not* manifest itself until we move into runlevel 3 of the
bootup process.

    sometimes-rpc4 is port 32770, which rpcinfo -p shows us to be
        nlockmgr.
    nfs is port 2049.

c) netstat -apn just so we know what ports are in use (state LISTEN for
all but port 32770, which has no state listed):

    Proto Recv-Q Send-Q Local Address  Foreign Address PID/Program name

    tcp        0      0 0.0.0.0:2049   0.0.0.0:*       -                  
    udp    31752      0 0.0.0.0:32770  0.0.0.0:*       - 
    udp        0      0 0.0.0.0:32768  0.0.0.0:*       88/rpc.statd     
    udp        0      0 0.0.0.0:32769  0.0.0.0:*       90/rpc.mountd      

d) rpcinfo -p

       program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100007    2   udp    680  ypbind
    100007    1   udp    680  ypbind
    100007    2   tcp    683  ypbind
    100007    1   tcp    683  ypbind
    100004    2   udp    685  ypserv
    100004    1   udp    685  ypserv
    100004    2   tcp    688  ypserv
    100004    1   tcp    688  ypserv
    100009    1   udp    687  yppasswdd
    100024    1   udp  32768  status
    100024    1   tcp  32768  status
    100005    1   udp  32769  mountd
    100005    1   tcp  32769  mountd
    100005    2   udp  32769  mountd
    100005    2   tcp  32769  mountd
    100005    3   udp  32769  mountd
    100005    3   tcp  32769  mountd
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs
    100021    1   udp  32770  nlockmgr
    100021    3   udp  32770  nlockmgr
    100021    4   udp  32770  nlockmgr
    100021    1   tcp  32770  nlockmgr
    100021    3   tcp  32770  nlockmgr
    100021    4   tcp  32770  nlockmgr

So, am I right in thinking it's a lockd problem? rpc.statd seems to be
okay, but I could be wrong..

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
