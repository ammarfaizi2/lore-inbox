Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWCQVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWCQVQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWCQVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:16:30 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:44203 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932791AbWCQVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:16:29 -0500
In-Reply-To: <6CCFFBB4-CDE0-4DC0-A4D7-A3E7398B2494@kernel.crashing.org>
References: <6CCFFBB4-CDE0-4DC0-A4D7-A3E7398B2494@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A19BA6C-6308-4DFC-B70D-A0AE0E144B59@kgala.com>
Cc: lm-sensors@lm-sensors.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar@kgala.com>
Subject: Re: I2C-virtual and locking?
Date: Fri, 17 Mar 2006 15:16:58 -0600
To: Greg KH <gregkh@suse.de>, khali@linux-fr.org
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kgala.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 17, 2006, at 12:54 PM, Kumar Gala wrote:

> I'm looking at porting the i2c-virtual code from 2.4 to 2.6.  One  
> thing I'm not clear on is the use of i2c_add_adapter_nolock() by  
> the old code.  The only reference I can find related to this is:
>
> http://archives.andrew.net.au/lm-sensors/msg31060.html
>
> I can't think of a reason why locking would be in issue when adding  
> or removing of a virtual adapter.  Anyone have an additional ides  
> on this?

Ok, so I figured out why the _nolock() versions exist.  In  
i2c_driver_register we take the core_list lock.  Eventually we will  
call i2c_probe() which should call driver->attach_adapter().  For a  
virtual bus the driver's attach_adapter() will end up calling  
i2c_virt_create_adapter() which will end up calling i2c_add_adapter()  
which will never get the core_list lock.

So should we integrate the concept of virtual adapters into the i2c  
core and have it such that i2c_virt_create_adapter()/ 
i2c_virt_remove_adapter() expects the caller to have the core_list  
lock already?

- kumar
