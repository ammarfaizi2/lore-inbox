Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVE0VSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVE0VSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVE0VSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:18:12 -0400
Received: from smtp06.auna.com ([62.81.186.16]:36294 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262599AbVE0VSD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:18:03 -0400
Date: Fri, 27 May 2005 21:18:00 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	<1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
	<1116369585l.8840l.0l@werewolf.able.es> <s5hoeb8sleq.wl@alsa2.suse.de>
	<1117151518l.7637l.0l@werewolf.able.es> <s5his15xaz2.wl@alsa2.suse.de>
In-Reply-To: <s5his15xaz2.wl@alsa2.suse.de> (from tiwai@suse.de on Fri May
	27 11:41:05 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117228680l.24619l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 27 May 2005 23:18:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.27, Takashi Iwai wrote:
> At Thu, 26 May 2005 23:51:58 +0000,
> J.A. Magallon wrote:
> 
> > A side note. In the process of solving all this, I tried to generate a patch
> > for 1.0.9rc4a against -mm. I noticed some things:
> > - Your code reverts some in-kernel changes related to
> >     if (ptr)
> >         kfree(ptr)
> >   The if is killed in mainline, as kfree accepts null pointers.
> 
> Could you point which places?
> 

Oops, I think this is not ALSA specific code.
I took the directory alsa-kernel, in the alsa tarball, and diffed against
2.6.12-rc5-mm1:

--- /usr/src/linux-2.6.12-rc5-mm1/sound/core/seq/oss/seq_oss_synth.c    2005-05-27 00:25:37.000000000 +0200
+++ alsa-kernel/core/seq/oss/seq_oss_synth.c    2005-01-20 18:42:37.000000000 +0100
@@ -325,10 +325,14 @@
            }
            snd_use_lock_free(&rec->use_lock);
        }
-       kfree(info->sysex);
-       info->sysex = NULL;
-       kfree(info->ch);
-       info->ch = NULL;
+       if (info->sysex) {
+           kfree(info->sysex);
+           info->sysex = NULL;
+       }
+       if (info->ch) {
+           kfree(info->ch);
+           info->ch = NULL;
+       }
    }
    dp->synth_opened = 0;
    dp->max_synthdev = 0;
@@ -414,10 +418,14 @@
                      dp->file_mode) < 0) {
            midi_synth_dev.opened--;
            info->opened = 0;
-           kfree(info->sysex);
-           info->sysex = NULL;
-           kfree(info->ch);
-           info->ch = NULL;
+           if (info->sysex) {
+               kfree(info->sysex);
+               info->sysex = NULL;
+           }
+           if (info->ch) {
+               kfree(info->ch);
+               info->ch = NULL;
+           }
        }
        return;
    }

This looks like OSS code. Why does the tarball include OSS code ?
Which is the correct way to generate a patch against a kernel tree ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


