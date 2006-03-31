Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWCaEMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCaEMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 23:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCaEMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 23:12:14 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:55937 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1751210AbWCaEMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 23:12:13 -0500
Message-ID: <442CACC0.1060308@wolfmountaingroup.com>
Date: Thu, 30 Mar 2006 21:14:56 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
 reset.
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com> <442C8069.507@wolfmountaingroup.com> <20060331003506.GU2172@austin.ibm.com>
In-Reply-To: <20060331003506.GU2172@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:

>On Thu, Mar 30, 2006 at 06:05:45PM -0700, Jeff V. Merkey wrote:
>  
>
>>Linas Vepstas wrote:
>>    
>>
>
>Well, these comments have nothing to do with my patch, but ... 
>anyway ... 
>
>  
>
>>The driver also needs to be fixed to allow clearing of the stats (like 
>>all the other adapter drivers). At present, when I run performance
>>and packet drop counts on the cards, I cannot reset the stats with this 
>>code because the driver stores them in the e100_adapter
>>structure. This is busted.
>>
>>This function:
>>
>>int clear_network_device_stats(BYTE *name)
>>    
>>
>
>I couldn't find such a function in the kernel.
> 
>  
>
>>does not work on e1000 due to this section of code:
>>
>>void
>>e1000_update_stats(struct e1000_adapter *adapter)
>>{
>>
>>adapter->stats.xofftxc += E1000_READ_REG(hw, XOFFTXC);
>>adapter->stats.fcruc += E1000_READ_REG(hw, FCRUC);
>>    
>>
>
>These are hardware stats ... presumably useless without
>a detailed understanding of the guts of the e1000.
>
>  
>
>>//NOTE These stats need to be stored in the stats structure so they can 
>>be cleared by
>>statistics monitoring programs.
>>    
>>
>
>I can't imagine what generic interface would allow these 
>to be viewed.
>
>  
>
>>/* Fill out the OS statistics structure */
>>
>>adapter->net_stats.rx_packets = adapter->stats.gprc;
>>adapter->net_stats.tx_packets = adapter->stats.gptc;
>>adapter->net_stats.rx_bytes = adapter->stats.gorcl;
>>adapter->net_stats.tx_bytes = adapter->stats.gotcl;
>>    
>>
>
>Now *these* are generic ... and fixing this so that the 
>stats increment instead of over-riding would take 
>maybe half-an-hour or so; this is not hard to do ... !? 
>
>Do you want me to write a patch to do this?
>
>--lina
>  
>
Yes, we need one. The adapter needs to maintain these stats from the
registers in the kernel structure and not
its own local variables. That way, when someone calls to clear the stats
for testing and analysis purposes,
they zero out and are reset.

The code fragment above is in our analysis code not the kernel, but we
use it to test performance of various
vendor cards. It's provided as an example of this capability.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


