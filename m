Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQKFNWr>; Mon, 6 Nov 2000 08:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129876AbQKFNWi>; Mon, 6 Nov 2000 08:22:38 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:30707 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129805AbQKFNWW>;
	Mon, 6 Nov 2000 08:22:22 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com> 
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com>  <3A0698A8.8D00E9C1@mandrakesoft.com> <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 13:21:44 +0000
Message-ID: <8006.973516904@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think we're getting confused. What I'm advocating is something like this:

init_module()
{
	struct mixer_levels *levels;

	levels = inter_module_get("mysoundcard_mixerlevels");

	if (!levels)
		/* We haven't been loaded before. Default to zero */
		levels = &default_levels;

	init_hardware(levels);
}

cleanup_module()
{
	struct mixer_levels *levels = kmalloc(sizeof *levels);

	if (levels) {
		/* Record current the levels so we can init the hardware
		   to the same next time we're loaded */
		memcpy(levels, current_levels, sizeof(*levels));
		inter_module_register("mysoundcard_mixerlevels", levels);
	}
}


(Note it's pseudocode. I _know_ it doesn't compile and that the name we 
pass to inter_module_register is removed when the module is unloaded. Oh 
and that inter_module_register will panic() and kill the whole system on 
the second unload because a registration with that name already exists.)


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
