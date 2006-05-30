Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWE3LGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWE3LGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWE3LGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:06:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932256AbWE3LGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:06:32 -0400
Subject: Re: BUG: possible deadlock detected! (sound) [Was: 2.6.17-rc5-mm1]
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, tiwai@suse.de,
       emu10k1-devel@lists.sourceforge.net, James@superbug.demon.co.uk,
       perex@suse.cz
In-Reply-To: <447C22CE.2060402@gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <447C22CE.2060402@gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:06:28 +0200
Message-Id: <1148987188.3636.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 147 +0159, Jiri Slaby wrote:

(I've turned your backtrace upside down to show it "chronological")

 [<c05911e0>] alsa_emu10k1_synth_init+0x22/0x24
 [<c0333d04>] snd_seq_device_register_driver+0x8f/0xeb

this one does:

       mutex_lock(&ops->reg_mutex);
       ...
       list_for_each(head, &ops->dev_list) {
                struct snd_seq_device *dev = list_entry(head, struct snd_seq_device, list);
                init_device(dev, ops);
       }
       mutex_unlock(&ops->reg_mutex);

 [<c0333537>] init_device+0x2c/0x94
  which calls into the driver
 [<c0352c39>] snd_emu10k1_synth_new_device+0xe7/0x14e
 [<c0353f50>] snd_emux_register+0x10d/0x13f
 [<c0358260>] snd_emux_init_seq_oss+0x35/0x9c
 [<c0333aa0>] snd_seq_device_new+0x96/0x111

and this one does
        mutex_lock(&ops->reg_mutex);
        list_add_tail(&dev->list, &ops->dev_list);
        ops->num_devices++;
        mutex_unlock(&ops->reg_mutex);


so... on first sight this looks like a real deadlock;
unless the ALSA folks can tell me why "ops" is always different,
and what the lock ordering rules between those is...


