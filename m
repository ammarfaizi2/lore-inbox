Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933494AbWKPNj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933494AbWKPNj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933490AbWKPNj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:39:26 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:2945 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S933494AbWKPNjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:39:25 -0500
Message-ID: <363684361.17920@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 16 Nov 2006 21:39:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] readahead: state based method - aging accounting
Message-ID: <20061116133919.GA6645@mail.ustc.edu.cn>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061115075007.832957580@localhost.localdomain> <363577024.21908@ustc.edu.cn> <Pine.LNX.4.64.0611150853510.19227@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611150853510.19227@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 08:54:44AM -0800, Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Wu Fengguang wrote:
> 
> > Collect info about the global available memory and its consumption speed.
> > The data are used by the stateful method to estimate the thrashing threshold.
> 
> Looks like you should use a ZVC counter for total scanned. See 
> include/linux/mmzone.h.

OK.

By using zone.total_scanned, I have chose an easy way :)

To do the general vm timing in something like zone.vm_stat[NR_SCAN_INACTIVE],
a set of new functions will be required:

        global_page_state_raw()
        zone_page_state_raw()
        node_page_state_raw()

They do not check overflows, so that we can do

        time_elapsed = new_raw_value - old_raw_value;

However, before introducing the ugly *_raw() functions, I'd like to know if

        #ifdef CONFIG_SMP
                if (x < 0)
                        x = 0;
        #endif  

really helps some big NUMA system. I suspect object counters like
NR_FILE_PAGES will _never_ overflow, and an accumulated counter like
NR_VMSCAN_WRITE is expected to overflow. In either case, it is ok to
return an unsigned long raw counter.

Regards,
Wu
