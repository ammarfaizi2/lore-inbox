Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUHQWYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUHQWYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUHQWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:24:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:23463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266802AbUHQWYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:24:10 -0400
Date: Tue, 17 Aug 2004 15:27:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-Id: <20040817152742.17d3449d.akpm@osdl.org>
In-Reply-To: <20040817212510.GA744@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	<20040817212510.GA744@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > This patch should clear up some confusion between driver model and
> > drivers people, and also prepares way to add runtime power managment
> > later. Please apply,
> 
> PCI states are now marked with PCI_D? so that confusion is not
> possible. Andrew complained about warning in to_pci_state(); I do not
> see it, but I added catch-all return anyway.
> 
> I'd like this to be applied, so I can start fixing the drivers...
> 

Sure, let's try to get this done.

> +static inline enum pci_state to_pci_state(suspend_state_t state)
> +{
> +	if (SUSPEND_EQ(state, PM_SUSPEND_ON))
> +		return PCI_D0;
> +	if (SUSPEND_EQ(state, PM_SUSPEND_STANDBY))
> +		return PCI_D1;
> +	if (SUSPEND_EQ(state, PM_SUSPEND_MEM))
> +		return PCI_D3hot;
> +	if (SUSPEND_EQ(state, PM_SUSPEND_DISK))
> +		return PCI_D3cold;
> +	BUG();
> +	return PCI_D0;	/* akpm complained about warnings? */
> +}
> +
> ...
> +/*
> + * For now, drivers only get system state. Later, this is going to become
> + * structure or something to enable runtime power managment.
> + */
> +typedef enum system_state suspend_state_t;
> +
> +#define SUSPEND_EQ(a, b) (a == b)
> +
>  enum {
>  	PM_DISK_FIRMWARE = 1,
>  	PM_DISK_PLATFORM,

This is a bit ugly, and I don't think it actually works.

If, at some time in the future you change the suspend state to a struct
then you will want to pass that thing around by reference, not by value. 
Hence your new suspend_state_t will need to be typecast to a pointer to
struct, and not a struct.  And that's not a thing which we do in-kernel
much at all.  (There's nothing wrong with the practice per-se, but in the
kernel it does violate the principle of least surprise).

So if you really do intend to add more things to the suspend state I'd
suggest that you set the final framework in place immediately.  Do:

struct suspend_state {
	enum system_state state;
}

static inline enum pci_state to_pci_state(struct suspend_state *state)
{
	if (state->state == PM_SUSPEND_ON)
		return PCI_D0;
	if (state->state == PM_SUSPEND_STANDBY)
		return PCI_D1;
	...
}
