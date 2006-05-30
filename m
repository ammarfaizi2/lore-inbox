Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWE3M7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWE3M7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWE3M7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:59:41 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:15562 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751090AbWE3M7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:59:40 -0400
Subject: Re: BUG: possible deadlock detected! (sound) [Was: 2.6.17-rc5-mm1]
From: Arjan van de Ven <arjan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, James@superbug.demon.co.uk,
       emu10k1-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jiri Slaby <jirislaby@gmail.com>
In-Reply-To: <s5h3berd6ne.wl%tiwai@suse.de>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <447C22CE.2060402@gmail.com>
	 <1148987188.3636.52.camel@laptopd505.fenrus.org>
	 <s5h3berd6ne.wl%tiwai@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 14:59:06 +0200
Message-Id: <1148993947.3636.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:44 +0200, Takashi Iwai wrote:
> This ops is a unique object assigned to a different "id" string.
> 
> The first snd_seq_device_register_driver() called from emu10k1_synth.c
> is the registration for the id "snd-synth-emu10k1".
> Then in init_device(), the corresponding devices are initialized, and
> one callback registers again another device for OSS sequencer with a
> different id "snd-seq-oss" via snd_seq_device_new() inside the lock.
> Now it hits the lock-detector but the lock should belong to a
> different ops object in practice.
> 
> This nested lock may happen only in two drivers, emu10k1-synth and
> opl3, and only together with OSS emulation.  Since the OSS emulation
> layer don't do active registration from itself, no deadlock should
> happen (in theory -- I may oversee something :)

ok fair enough

Jiri, can you test the patch below? (I don't have this hardware)

The ops structure has complex locking rules, where not all ops are
equal, some are subordinate on others for some complex sound cards. This
requires for lockdep checking that each individual reg_mutex is
considered in separation for its locking rules.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 sound/core/seq/seq_device.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
===================================================================
--- linux-2.6.17-rc4-mm3-lockdep.orig/sound/core/seq/seq_device.c
+++ linux-2.6.17-rc4-mm3-lockdep/sound/core/seq/seq_device.c
@@ -46,6 +46,7 @@
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/lockdep.h>
 
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA sequencer device management");
@@ -73,6 +74,8 @@ struct ops_list {
 	struct mutex reg_mutex;
 
 	struct list_head list;	/* next driver */
+
+	struct lockdep_type_key reg_mutex_key;
 };
 
 
@@ -379,7 +382,7 @@ static struct ops_list * create_driver(c
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
-	mutex_init(&ops->reg_mutex);
+	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
 	/* lock this instance */

