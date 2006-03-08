Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWCHANA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWCHANA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWCHANA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:13:00 -0500
Received: from hpcn.ca.sandia.gov ([146.246.248.58]:25481 "EHLO
	hpcn.ca.sandia.gov") by vger.kernel.org with ESMTP id S1751304AbWCHAM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:12:59 -0500
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
From: Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Shirley Ma <xma@us.ibm.com>, netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>,
       mst@mellanox.co.il
In-Reply-To: <20060307134907.733d3d27@localhost.localdomain>
References: <OF336D72E6.999D2A30-ON8725712A.00117C92-8825712A.00116629@us.ibm.com>
	 <1141767891.6119.903.camel@localhost>
	 <20060307134907.733d3d27@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 16:11:37 -0800
Message-Id: <1141776697.6119.938.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 13:49 -0800, Stephen Hemminger wrote:
> On Tue, 07 Mar 2006 13:44:51 -0800
> Matt Leininger <mlleinin@hpcn.ca.sandia.gov> wrote:
> 
> > On Mon, 2006-03-06 at 19:13 -0800, Shirley Ma wrote:
> > > 
> > > > More likely you are getting hit by the fact that TSO prevents the
> > > congestion
> > > window from increasing properly. This was fixed in 2.6.15 (around mid
> > > of Nov 2005). 
> > > 
> > > Yep, I noticed the same problem. After updating to the new kernel, the
> > > performance are much better, but it's still lower than before.
> > 
> >  Here is an updated version of OpenIB IPoIB performance for various
> > kernels with and without one of the TSO patches.  The netperf
> > performance for the latest kernels has not improved the TSO performance
> > drop.
> > 
> >   Any comments or suggestions would be appreciated.
> > 
> >   - Matt
> 
> Configuration information? like did you increase the tcp_rmem, tcp_wmem?
> Tcpdump traces of what is being sent and available window?
> Is IB using NAPI or just doing netif_rx()?

  I used the standard setting for tcp_rmem and tcp_wmem.   Here are a
few other runs that change those variables.  I was able to improve
performance by ~30MB/s to 403 MB/s, but this is still a ways from the
474 MB/s before the TSO patches.

 Thanks,

	- Matt

All benchmarks are with RHEL4 x86_64 with HCA FW v4.7.0
dual EM64T 3.2 GHz PCIe IB HCA (memfull)
patch 1 - remove changeset 314324121f9b94b2ca657a494cf2b9cb0e4a28cc
msi_x=1 for all tests

Kernel                OpenIB     netperf (MB/s)  
2.6.16-rc5           in-kernel    403      
tcp_wmem 4096 87380 16777216 tcp_rmem 4096 87380 16777216

2.6.16-rc5           in-kernel    395      
tcp_wmem 4096 102400 16777216 tcp_rmem 4096 102400 16777216

2.6.16-rc5           in-kernel    392      
tcp_wmem 4096 65536 16777216 tcp_rmem 4096 87380 16777216

2.6.16-rc5           in-kernel    394      
tcp_wmem 4096 131072 16777216 tcp_rmem 4096 102400 16777216

2.6.16-rc5           in-kernel    377      
tcp_wmem 4096 131072 16777216 tcp_rmem 4096 153600 16777216

2.6.16-rc5           in-kernel    377      
tcp_wmem 4096 131072 16777216 tcp_rmem 4096 131072 16777216

2.6.16-rc5           in-kernel    353      
tcp_wmem 4096 262144 16777216 tcp_rmem 4096 262144 16777216

2.6.16-rc5           in-kernel    305      
tcp_wmem 4096 262144 16777216 tcp_rmem 4096 524288 16777216

2.6.16-rc5           in-kernel    303      
tcp_wmem 4096 131072 16777216 tcp_rmem 4096 524288 16777216

2.6.16-rc5           in-kernel    290      
tcp_wmem 4096 524288 16777216 tcp_rmem 4096 524288 16777216

2.6.16-rc5           in-kernel    367      default tcp values

--------------------
All with standard tcp settings
Kernel                OpenIB     netperf (MB/s)  
2.6.16-rc5           in-kernel    367      
2.6.15               in-kernel    382
2.6.14-rc4 patch 12  in-kernel    436 
2.6.14-rc4 patch 1   in-kernel    434 
2.6.14-rc4           in-kernel    385 
2.6.14-rc3           in-kernel    374 
2.6.13.2             svn3627      386 
2.6.13.2 patch 1     svn3627      446 
2.6.13.2             in-kernel    394 
2.6.13-rc3 patch 12  in-kernel    442 
2.6.13-rc3 patch 1   in-kernel    450 
2.6.13-rc3           in-kernel    395
2.6.12.5-lustre      in-kernel    399  
2.6.12.5 patch 1     in-kernel    464
2.6.12.5             in-kernel    402 
2.6.12               in-kernel    406 
2.6.12-rc6 patch 1   in-kernel    470 
2.6.12-rc6           in-kernel    407
2.6.12-rc5           in-kernel    405 
2.6.12-rc5 patch 1   in-kernel    474
2.6.12-rc4           in-kernel    470 
2.6.12-rc3           in-kernel    466 
2.6.12-rc2           in-kernel    469 
2.6.12-rc1           in-kernel    466
2.6.11               in-kernel    464 
2.6.11               svn3687      464 
2.6.9-11.ELsmp       svn3513      425  (Woody's results, 3.6Ghz EM64T) 


