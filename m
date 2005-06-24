Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263317AbVFXWSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbVFXWSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbVFXWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:18:33 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:12499 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263332AbVFXWPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:15:16 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Fri, 24 Jun 2005 15:15:06 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Fwd: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
In-Reply-To: <200506250157.14499.adobriyan@gmail.com>
Message-ID: <Pine.LNX.4.62.0506241514440.19335@qynat.qvtvafvgr.pbz>
References: <200506250157.14499.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's what happens.

happy1-p:~# ifconfig eth11 192.168.255.1
SIOCSIFFLAGS: Invalid argument
happy1-p:~# tail -3 /var/log/messages
Jun 24 15:14:01 happy1-p /USR/SBIN/CRON[392]: (root) CMD (touch 
/tmp/.crond_running >/dev/null 2>/dev/null)
Jun 24 15:14:22 happy1-p kernel: request_irq: IRQ requested is greater 
than NR_IRQs!
Jun 24 15:14:22 happy1-p kernel: e1000: eth11: e1000_up: Unable to 
allocate interrupt Error: -22

On Sat, 25 Jun 2005, Alexey Dobriyan wrote:

> Date: Sat, 25 Jun 2005 01:57:13 +0400
> From: Alexey Dobriyan <adobriyan@gmail.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
> Subject: Fwd: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
> 
> David, please try this debugging patch.
>
> You can also register at http://bugme.osdl.org/createaccount.cgi and add
> yourself to CC list.
>
> ----------  Forwarded Message  ----------
>
> Subject: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
> Date: Saturday 25 June 2005 01:27
> From: bugme-daemon@kernel-bugs.osdl.org
> To: adobriyan@gmail.com
>
> http://bugzilla.kernel.org/show_bug.cgi?id=4774
>
>
> ------- Additional Comments From nacc@us.ibm.com  2005-06-24 14:27 -------
> Created an attachment (id=5211)
> --> (http://bugzilla.kernel.org/attachment.cgi?id=5211&action=view)
> Debugging patch
>
> That e1000 error message indicates an EINVAL error code, which is from this
> code:
>
> 	if ((irqflags & SA_SHIRQ) && !dev_id)
> 		return -EINVAL;
> 	if (irq >= NR_IRQS)
> 		return -EINVAL;
> 	if (!handler)
> 		return -EINVAL;
>
> I don't think it's the last one, because e1000_intr (which is sent in to
> request_irq() from e1000) is prototyped/defined. I spun up a patch to spit out
> some debugging here which simply inserts some printks (if the only driver which
> gets this warning is e1000, then it shouldn't flood your logs) -- basically
> narrowing down which error condition is causing the failure. I'm guessing it's
> probably the first case, but let's be sure.
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
