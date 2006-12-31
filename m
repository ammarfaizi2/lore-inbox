Return-Path: <linux-kernel-owner+w=401wt.eu-S933170AbWLaNYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933170AbWLaNYS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933171AbWLaNYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:24:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:32754 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933170AbWLaNYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:24:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HWDKHwzqsigB50L5AKlXRBnQ1PZIgQKl4s9c1MQm7nR7ZhOM5EsMPtZgyET1wfBAYqhKoR/VMNGQDgy+T1bOd3Tw1kt6nmcyt5XAZ2+mUNq5OqaG5AnvMbDLU+xyCYiz57ymq6HbeKAP68DMX27VRmtTh1rir7uE3dkl6UJWgZk=
Message-ID: <84144f020612310524u5e2e179esd5af4a11c1c1d2f8@mail.gmail.com>
Date: Sun, 31 Dec 2006 15:24:15 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mitch Bradley" <wmb@firmworks.com>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Cc: "OLPC Developer's List" <devel@laptop.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Jim Gettys" <jg@laptop.org>
In-Reply-To: <459714A6.4000406@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <459714A6.4000406@firmworks.com>
X-Google-Sender-Auth: 6691b2f2fb625140
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/06, Mitch Bradley <wmb@firmworks.com> wrote:
> diff --git a/arch/i386/kernel/ofw_fs.c b/arch/i386/kernel/ofw_fs.c
> new file mode 100644
> index 0000000..30ca359
> --- /dev/null
> +++ b/arch/i386/kernel/ofw_fs.c
> @@ -0,0 +1,261 @@
> +/* 1275 in little-endian ASCII (for IEEE 1275 - the Open Firmware Standard) */
> +#define OFWFS_MAGIC 0x35373231

Please put this in <linux/magic.h>

On 12/31/06, Mitch Bradley <wmb@firmworks.com> wrote:
> +       case S_IFREG:
> +               inode->i_fop = &ofwfs_property_operations;
> +               inode->i_bytes = ((struct propval *)data)->length;
> +               inode->i_size = (loff_t)(((struct propval *)data)->length);

As you need the struct twice, use a local variable.

On 12/31/06, Mitch Bradley <wmb@firmworks.com> wrote:
> +static int ofwfs_create_props(struct super_block *sb, struct dentry *dir,
> +               phandle node)
> +{
> +       char propname[32];
> +       int security, len;
> +       struct propval *propval;
> +       int ret = 0;
> +       int flag;
> +
> +       propname[0] = '\0';
> +
> +       while ((void)callofw("nextprop", 3, 1, node, propname, propname,
> +                             &flag), flag == 1) {

Please do the call within the loop body and use an explicit bereak.

> +               security = strncmp(propname, "security-", 9) == 0;
> +               len = 0;

Redundant assignment, no?

> +               if (!security)
> +                       (void)callofw("getproplen", 2, 1, node, propname, &len);

We don't use void casts to suppress return value in Linux. You can
just drop it (elsewhere too).

On 12/31/06, Mitch Bradley <wmb@firmworks.com> wrote:
> +out:
> +       if (ret) {
> +               WARN_ON(1);
> +/*
> +               ofwfs_remove_props(sb, dir);
> +*/
> +       }

Hmm?

On 12/31/06, Mitch Bradley <wmb@firmworks.com> wrote:
> +static int __init ofwfs_init(void)
> +{
> +       int ret;
> +
> +       ret = register_filesystem(&ofwfs_type);
> +       if (ret)
> +               return ret;
> +
> +       kern_mount(&ofwfs_type);

kern_mount can fail so you'd better do IS_ERR/PTR_ERR here.

> diff --git a/include/asm-i386/callofw.h b/include/asm-i386/callofw.h
> new file mode 100644
> index 0000000..594cb63
> --- /dev/null
> +++ b/include/asm-i386/callofw.h
> +#include <linux/types.h>
> +
> +typedef void *phandle;

The typedef seems useless and confusing at best. Can we drop it?
