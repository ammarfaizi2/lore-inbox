Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTERSFB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 14:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTERSFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 14:05:01 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:44707 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262153AbTERSE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 14:04:59 -0400
Date: Sun, 18 May 2003 20:17:31 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Alexey Mahotkin <alexm@hsys.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030518181731.GA29510@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <877k8oqlkh.fsf@192.168.10.23>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877k8oqlkh.fsf@192.168.10.23>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 08:14:06PM +0400, Alexey Mahotkin wrote:
> 
> Two comments on firmware_class_hotplug(), maybe both are irrelevant.
> 
> +int firmware_class_hotplug(struct class_device *class_dev, char **envp,
> +			   int num_envp, char *buffer, int buffer_size)
> +{
> +	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
> +	int i=0;
> +	char *scratch=buffer;
> +
> +	if (buffer_size < (FIRMWARE_NAME_MAX+10))
> +		return -ENOMEM;
> +
> +	envp [i++] = scratch;
> +	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
> +	return 0;
> +}
> +
> 
> First, I do not understand how the environment is handled here. 

 You can take a look at lib/kobject.c:kset_hotplug()

> You're just setting first element of provided environment to
> "FIRMWARE=%s", possibly overwriting the existing value.

 envp points to the first empty slot of the environment being
 constructed, so no, I am not overwriting anything.

> Then why are you incrementing `i'?  Why are you using `i' at all?  Why
> are you incrementing `scratch'?

 The code is ready to add a new environment variable if needed. If we
 really don't need more variables, it could be simplified, but I don't
 think it is so important.
 
> Ah, it seems like you should be using num_envp somehow, and you're not.
 
 OK, I just added:
	if (num_envp < 1)
		return -ENOMEM;

> Also, environment pointer list must be terminated with a NULL pointer. Is
> it not done or is that handled somewhere else?

 The envp array we get is reset to zero, so anything we don't explicitly
 set is already NULL.

> The machine I have 2.5.69 sources is not reachable now so I cannot
> check it.  Sorry if I am wrong.

 The num_envp issue was real, and anyway, I appreciate a little
 feedback, it seams like people don't hack the kernel on Sunday :-P

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
