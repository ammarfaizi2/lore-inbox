Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTIWEaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 00:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTIWEaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 00:30:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10245 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263258AbTIWEaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 00:30:00 -0400
Date: Tue, 23 Sep 2003 06:28:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923042855.GF589@alpha.home.local>
References: <20030922194833.GA2732@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922194833.GA2732@velociraptor.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(it was from me)
 
On Mon, Sep 22, 2003 at 09:48:33PM +0200, Andrea Arcangeli wrote:
> Hi,
> 
> I'm rejecting on the log-buf-len feature in 2.4.23pre5, the code in
> mainline is worthless for any distributor, shipping another rpm package
> just for the bufsize would be way overkill.
> 
> Please backout the below (extracted from bkcvs) and apply this one
> instead:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22aa1/00_log-buf-len-1

Well, Andrea, I've looked at your patch. I really like the dynamic size
reconfiguration, but:
  - now it becomes mandatory to add a command line option, just for this. It's
    annoying when you want to build install images for many systems. I've
    always considered that command line parameters should be limited to the
    strict minimum to have a system boot reliably (root=, console=, very few
    IDE/SCSI/ACPI tuning when absolutely needed) and that's all.
  - what does the initial __log_buf[] become after log_buf_len_setup() ? can
    these 64 kB be freed or are they definitely lost ?

I think that perhaps we should merge the two things, but reconfigure them
differently :

  - be able to specify de DEFAULT buffer size at compile time.
  - have it reconfigurable at run time with a sysctl (this could be something
    next to 'prink', or even a write to kmsg). This way, if you detect that
    your system is still loosing messages under load, you have a chance to
    catch them all.
  - initialize the buffer with allocated memory from the beginning so that we
    can free it when changing the buffer size. 

I can spend a few hours working with you on this if you're interested. But be
assured that I know enough people who would complain about being forced to
add a new boot option to their lilo.conf.

Cheers,
Willy

