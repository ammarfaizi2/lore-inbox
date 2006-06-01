Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWFAP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWFAP34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWFAP34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:29:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:21020 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030200AbWFAP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:29:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ZUw0t9ngoAzYo36wT0FbZhcqH8T063U+w+zjWV7sL1QrMjIom2B/j2BG0iI1Lmxou7B5/ZwGNASDVT2Jkxua+ZAR+VsSQVA+T+dqwSWLGSUtHC8nEGAVrMTcCZ527QvlV7ukBH8YfzehvOMTqbAu8hgAXgf9jXbbgkf+97pa9Xc=
Message-ID: <447F076F.9020209@gmail.com>
Date: Thu, 01 Jun 2006 17:27:20 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Takashi Iwai <tiwai@suse.de>, perex@suse.cz, James@superbug.demon.co.uk,
       emu10k1-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG: possible deadlock detected! (sound) [Was: 2.6.17-rc5-mm1]
References: <20060530022925.8a67b613.akpm@osdl.org>	 <447C22CE.2060402@gmail.com>	 <1148987188.3636.52.camel@laptopd505.fenrus.org>	 <s5h3berd6ne.wl%tiwai@suse.de> <1148993947.3636.61.camel@laptopd505.fenrus.org>
In-Reply-To: <1148993947.3636.61.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan van de Ven napsal(a):
> On Tue, 2006-05-30 at 14:44 +0200, Takashi Iwai wrote:
>> This ops is a unique object assigned to a different "id" string.
>>
>> The first snd_seq_device_register_driver() called from emu10k1_synth.c
>> is the registration for the id "snd-synth-emu10k1".
>> Then in init_device(), the corresponding devices are initialized, and
>> one callback registers again another device for OSS sequencer with a
>> different id "snd-seq-oss" via snd_seq_device_new() inside the lock.
>> Now it hits the lock-detector but the lock should belong to a
>> different ops object in practice.
>>
>> This nested lock may happen only in two drivers, emu10k1-synth and
>> opl3, and only together with OSS emulation.  Since the OSS emulation
>> layer don't do active registration from itself, no deadlock should
>> happen (in theory -- I may oversee something :)
> 
> ok fair enough
> 
> Jiri, can you test the patch below? (I don't have this hardware)
It's gone in 2.6.17-rc5-mm2.
> 
> The ops structure has complex locking rules, where not all ops are
> equal, some are subordinate on others for some complex sound cards. This
> requires for lockdep checking that each individual reg_mutex is
> considered in separation for its locking rules.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> ---
>  sound/core/seq/seq_device.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
> ===================================================================
> --- linux-2.6.17-rc4-mm3-lockdep.orig/sound/core/seq/seq_device.c
> +++ linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
> @@ -46,6 +46,7 @@
>  #include <linux/kmod.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/lockdep.h>
>  
>  MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
>  MODULE_DESCRIPTION("ALSA sequencer device management");
> @@ -73,6 +74,8 @@ struct ops_list {
>  	struct mutex reg_mutex;
>  
>  	struct list_head list;	/* next driver */
> +
> +	struct lockdep_type_key reg_mutex_key;
>  };
>  
>  
> @@ -379,7 +382,7 @@ static struct ops_list * create_driver(c
>  
>  	/* set up driver entry */
>  	strlcpy(ops->id, id, sizeof(ops->id));
> -	mutex_init(&ops->reg_mutex);
> +	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
>  	ops->driver = DRIVER_EMPTY;
>  	INIT_LIST_HEAD(&ops->dev_list);
>  	/* lock this instance */
> 
> 

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEfwdvMsxVwznUen4RAohGAKCChQYCo4EPEG0CWDPcld15mZnWTwCeKU+2
l26ws9ExkuBo1wlT5nJ+uWg=
=vgxE
-----END PGP SIGNATURE-----
