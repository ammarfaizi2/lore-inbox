Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWBSTCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWBSTCN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWBSTCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:02:13 -0500
Received: from smtp.blackdown.de ([213.239.206.42]:63713 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S932205AbWBSTCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:02:11 -0500
From: Juergen Kreileder <jk@blackdown.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix snd-usb-audio in 32-bit compat environemt
References: <878xs85wn6.fsf@blackdown.de>
	<20060219175646.GB7797@mipter.zuzino.mipt.ru>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Sun, 19 Feb 2006 20:02:03 +0100
In-Reply-To: <20060219175646.GB7797@mipter.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Sun, 19 Feb 2006 20:56:46 +0300")
Message-ID: <87hd6vw4t0.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Sat, Feb 18, 2006 at 07:50:37PM +0100, Juergen Kreileder wrote:
>> I'm getting oopses with snd-usb-audio in 32-bit compat
>> environments: control_compat.c:get_ctl_type() doesn't initialize
>> 'info', so
>> 'itemlist[uinfo->value.enumerated.item]' in
>> usbmixer.c:mixer_ctl_selector_info() might access random memory
>> (The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
>> all problems because of the unsigned -> signed conversion.)
>
> IMO, what you did is an overkill.

The advantage of the longer fix is reduced stack usage.

> Does this patch fixes your problem?

Yes but you can have that even simpler:

--- linux-mm-vanilla/sound/core/control_compat.c	2006-02-18 17:00:17.000000000 +0100
+++ linux-mm/sound/core/control_compat.c	2006-02-19 19:41:51.000000000 +0100
@@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card 
 			int *countp)
 {
 	struct snd_kcontrol *kctl;
-	struct snd_ctl_elem_info info;
+	struct snd_ctl_elem_info info = {0};
 	int err;
 
 	down_read(&card->controls_rwsem);
=


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
