Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130408AbRCBLEF>; Fri, 2 Mar 2001 06:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130409AbRCBLD4>; Fri, 2 Mar 2001 06:03:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11275 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130408AbRCBLDg>;
	Fri, 2 Mar 2001 06:03:36 -0500
Date: Fri, 2 Mar 2001 11:03:18 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.2-ac8] misc_register() fix (was Re: Linux 2.4.2ac8
Message-ID: <20010302110318.C8678@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0103021010570.1338-100000@penguin.homenet> <Pine.LNX.4.21.0103021053290.1338-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103021053290.1338-100000@penguin.homenet>; from tigran@veritas.com on Fri, Mar 02, 2001 at 10:55:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 10:55:39AM +0000, Tigran Aivazian wrote:
> On Fri, 2 Mar 2001, Tigran Aivazian wrote:
> > On Thu, 1 Mar 2001, Alan Cox wrote:
> > > 2.4.2-ac8
> > > o	Stop two people claiming the same misc dev id	(Philipp Rumpf)
> > 
> > is this what has broken misc devi registration on my machine? I have two
> > misc devices -- microcode and psaux -- now (ac8) I get none, /proc/misc is
> > empty. Also, on boot gpm generates an "oops" from gpm.c(968) saying
> > "/dev/mouse: No such device"
> 
> Hi Alan,
> 
> here is the fix, tested, it works fine. The only unsatisfactory thing is
> that we do an extra if() on each iteration making misc_register()
> typically a few instructions slower. I will think a few minutes on how to
> make the old version work (i.e. I suspect it was just an incorrect walking
> of the misc_list in ac8).

See earlier patch.

> --- linux/drivers/char/misc.c.0	Fri Mar  2 09:35:01 2001
> +++ linux/drivers/char/misc.c	Fri Mar  2 10:01:17 2001
> @@ -175,14 +175,16 @@
>  	
>  	if (misc->next || misc->prev)
>  		return -EBUSY;
> +
>  	down(&misc_sem);
> -	c = misc_list.next;
>  
> -	while ((c != &misc_list) && (c->minor != misc->minor))
> +	c = misc_list.next;
> +	while (c != &misc_list) {
> +		if (c->minor == misc->minor) {
> +			up(&misc_sem);
> +			return -EBUSY;
> +		}
>  		c = c->next;
> -	if (c == &misc_list) {
> -		up(&misc_sem);
> -		return -EBUSY;
>  	}
>  
>  	if (misc->minor == MISC_DYNAMIC_MINOR) {

This is fine as well, and possibly more readable.
