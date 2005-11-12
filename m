Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVKLCNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKLCNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKLCNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:13:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750890AbVKLCNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:13:37 -0500
Date: Fri, 11 Nov 2005 18:13:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix leakes in request_firmware_nowait
Message-Id: <20051111181322.7fbb887a.akpm@osdl.org>
In-Reply-To: <4373C03F.1070301@free.fr>
References: <4373BF82.40003@free.fr>
	<4373C03F.1070301@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet <castet.matthieu@free.fr> wrote:
>
> @@ -511,18 +511,23 @@
>   {
>   	struct firmware_work *fw_work = arg;
>   	const struct firmware *fw;
>  +	int ret;
>   	if (!arg) {
>   		WARN_ON(1);
>   		return 0;
>   	}
>   	daemonize("%s/%s", "firmware", fw_work->name);
>  -	_request_firmware(&fw, fw_work->name, fw_work->device,
>  +	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
>   		fw_work->hotplug);
>  -	fw_work->cont(fw, fw_work->context);
>  -	release_firmware(fw);
>  +	if (ret < 0)
>  +		fw_work->cont(NULL, fw_work->context);
>  +	else {
>  +		fw_work->cont(fw, fw_work->context);
>  +		release_firmware(fw);
>  +	}
>   	module_put(fw_work->module);
>   	kfree(fw_work);
>  -	return 0;
>  +	return ret;
>   }

What does the call to fw_work->cont(NULL, ...) do?
