Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319224AbSHMX5s>; Tue, 13 Aug 2002 19:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319225AbSHMX5s>; Tue, 13 Aug 2002 19:57:48 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:9200 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S319224AbSHMX5o>;
	Tue, 13 Aug 2002 19:57:44 -0400
Date: Tue, 13 Aug 2002 20:01:32 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020814000132.GA24107@www.kroptech.com>
References: <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au> <20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au> <20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au> <20020813041011.GA12227@www.kroptech.com> <3D5899DB.B087E40D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5899DB.B087E40D@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 10:32:11PM -0700, Andrew Morton wrote:
> Adam Kropelin wrote:
> > 
> > On Mon, Aug 12, 2002 at 08:03:34PM -0700, Andrew Morton wrote:
> > > OK, tried that against a slow disk (13 megs/sec write bandwidth).  2.5.31,
> > > defalt writeback settings.
> > >
> > > ext3 is misbehaving:
> > > and takes 86 seconds.
> > >
> > > When the server is writing to ext2, it is good:
> > > and the transfer takes 54 seconds, which is wirespeed.
> > >
> > > Are you _sure_ it was bad with ext2?
> > 
> > Yes.

...but I was wrong.

> Sure looks like ext3.

..it was.

*Actually* switching to ext2 (rather than just pretending) made a
tremendous difference. New numbers:

2.5.31-stock: 1m 49s
2.5.31-akpm: 1m 50s
2.4.19-stock: 1m 34s

...but, applying the writeout threshold settings you suggested:

2.5.31-stock: 1m 34s
2.5.31-akpm: 1m 34s

(That's with dirty_background at 30%; 10% turned in the same numbers
as 30% did.)

Presumably with the disk as the bottleneck, the -akpm changes aren't
expected to do much. At least they're not degrading anything.

> So your wirespeed actually exceeds the disk speed.  That changes things.
...
> 
> 	batch_requests = 1;
> And in fs/mpage.c, set RATELIMIT_PAGES to 16.

These changes didn't have as much effect as the threshold tweaks:

2.5.31-stock: 1m 39s

..unless I added in the threshold tweaks as well, in which case:

2.5.31-stock: 1m 34s

...which is the same as the threshold tweaks alone.

> The application has to block, but the disk should certainly never
> fall idle.  I'll play with this a bit.  IDE ceased to be an option
> in 2.5.30, which does not aid this effort.

With ext2 and the threshold tweaks it never becomes idle. That is clearly
an ext3 issue now.

> fix one thing and break another.  Not a lot of effort has been put into
> fine tuning 2.5 for smoothness and latency thus far.

Understandably. I think it says a lot already that an untuned development
kernel can match the current release kernel. I'm sure once 2.5 gets into
the tweak 'n tune cycle we'll see it beating 2.4 hands down.

Actually 2.5 writeout to ext2 is far smoother than 2.4 already:

2.4.19:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  2      0   4400   1788 140520   0   0     0  7776 7434   892   2  47  51
 1  0  2      0   4408   1796 140492   0   0     0  7868 7315   873   0  50  50
 1  0  3      0   4428   1804 140484   0   0     0 10496 7327   877   3  56  41
 1  0  2      0   4372   1812 140516   0   0     0  8132 7239   872   0  53  47
 1  0  0      0   4408   1816 140460   0   0     4  5876 2415   255   0  17  83
 1  0  0      0   4376   1824 140528   0   0     0     0 7555   894   1  42  56
 0  0  2      0   4376   1832 140512   0   0     0  4096 7589   858   1  52  47
 1  0  1      0   4416   1840 140464   0   0     0  8052 7229   879   1  51  47
 0  0  1      0   4380   1848 140496   0   0     0 10180 7183   863   1  49  50
 1  0  1      0   4348   1856 140500   0   0     0  8080 7240   852   1  49  50
 1  0  1      0   4464   1864 140408   0   0     0  4504 7309   886   1  47  51
 0  0  1      0   4444   1872 140400   0   0     0  7284 7459   873   1  51  48
 0  0  3      0   4380   1880 140440   0   0     0 10184 7428   895   1  50  49
 1  0  1      0   4428   1888 140400   0   0     0  8092 7308   867   0  52  48

2.5.31:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0   7404      0 137796   0   0     0  4108 6933  1176   1  43  56
 1  0  0      0   4384      0 141048   0   0     0  8216 6918  1293   1  42  57
 0  0  0    104   4392      0 141472   0 104     0  4212 6909  1211   1  53  45
 0  0  1    120   4440      0 141488   0  16     0  8232 6860  1233   1  61  38
 1  0  1    120   4352      0 141628   0   0     0  4108 6810  1137   2  38  60
 0  0  0    120   4468      0 141508   0   0     0  8216 6848  1114   0  40  59
 1  0  0    120   4352      0 141608   0   0     0  4108 6817  1091   1  39  60
 0  0  1    120   4464      0 141528   0   0     0  8216 6846  1090   1  39  60
 0  0  0    120   4412      0 141568   0   0     0  4108 6836  1056   1  39  60
 0  0  1    120   4388      0 141588   0   0     0  8216 6863  1088   1  41  58
 1  0  0    120   4392      0 141608   0   0     0  4108 6899  1162   1  41  58
 0  0  0    120   4428      0 141572   0   0     0  8216 6917  1085   2  40  58
 0  0  0    120   4416      0 141592   0   0     0  4208 6887  1097   1  40  59

The oscillation between 8 MB and 4 MB is a little odd, but it's very consistent
and averages out to about 6 MB, which is exactly what the FTP session is doing.

Thanks for your insight and patience. I'm always excited to see another batch
of akpm patches show up on the list. If I can run other tests to help you, let
me know.

--Adam

