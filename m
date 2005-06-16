Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVFPS3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVFPS3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVFPS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:29:01 -0400
Received: from quark.didntduck.org ([69.55.226.66]:20407 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261722AbVFPS14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:27:56 -0400
Message-ID: <42B1C4EA.9060200@didntduck.org>
Date: Thu, 16 Jun 2005 14:28:58 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Warzecha <Douglas_Warzecha@dell.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, abhay_salunke@dell.com,
       matt_domsch@dell.com
Subject: Re: [PATCH 2.6.12-rc6] char: Add Dell Systems Management Base driver
References: <20050616173024.GA2596@sysman-doug.us.dell.com>
In-Reply-To: <20050616173024.GA2596@sysman-doug.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Warzecha wrote:
> This patch adds the Dell Systems Management Base driver.
> 
> The Dell Systems Management Base driver is a character driver that
> provides support needed by Dell systems management software to manage
> certain Dell systems.  The driver implements ioctls for Dell systems
> management software to use to communicate with the driver.
> 
> This driver has been tested with Dell systems management software
> on a variety of Dell systems.
> 
> By making a contribution to this project, I certify that:
> The contribution was created in whole or in part by me and
> I have the right to submit it under the open source license
> indicated in the file.
> 
> Signed-off-by: Doug Warzecha <Douglas_Warzecha@dell.com>
> ---

> +	/* generate SMI */
> +	asm("pushl %ebx");
> +	asm("pushl %ecx");
> +	asm("rep" : : "b" (command_buffer_phys_addr));
> +	asm("rep" : : "c" (ci_cmd->signature));
> +	outb(ci_cmd->command_code, ci_cmd->command_address);
> +	asm("popl %ecx");
> +	asm("popl %ebx");

This is wrong.  GCC doesn't guarantee that any registers or stack state 
is preserved between asm statements.  What you really want is:

asm("outb %b0,%w1" : :
	"a" (ci_cmd->command_code),
	"d" (ci_cmd->command_address),
	"b" (command_buffer_phys_addr),
	"c" (ci_cmd->signature));

This way you don't need to explicitly push/pop %ebx and %ecx, since GCC 
will know they are being used.  If the SMI changes any of the registers 
then they need to be changed to outputs so GCC knows that they are 
clobbered.

--
				Brian Gerst
