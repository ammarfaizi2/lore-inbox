Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286260AbRLTOjR>; Thu, 20 Dec 2001 09:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286265AbRLTOjH>; Thu, 20 Dec 2001 09:39:07 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:37642 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S286261AbRLTOi6>; Thu, 20 Dec 2001 09:38:58 -0500
Date: Thu, 20 Dec 2001 15:38:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Luca Montecchiani <m.luca@iname.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] Trident 4DWave DX/NX joystick support
Message-ID: <20011220153855.C30746@suse.cz>
In-Reply-To: <3C21229F.A6864423@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C21229F.A6864423@iname.com>; from m.luca@iname.com on Thu, Dec 20, 2001 at 12:28:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I must say I don't like the patch much. If there is anything going to be
added to trident.c in regards to enabling the joystick, I think most of
the pcigame.c code should be moved in there. That way, there won't be
resource conflicts and we won't lose any functionality.

Vojtech

On Thu, Dec 20, 2001 at 12:28:31AM +0100, Luca Montecchiani wrote:
> Hi!
> 
> Right now using the joystick with a trident sound card 
> on 2.4.x is not possible.
> 
> The joystick/pcigame give me tons of problems, like pci resource
> conflicts and oops, anyway I'll came back soon with more detailed
> data about that... 
> 
> Forgetting the enhanced game port we can use the old legacy ISA ns558
> driver but is a no go because the trident sound driver doesn't enable 
> that port :(
> 
> This patch allow to enable the legacy joystick port on 
> Trident 4DWave DX/NX.
> The patch adds a new trident module param (joystick)
> and a new config option.
> I didn't try with a monolithic kernel, I hope that joy driver
> driver will came after the sound driver.. 
> 
> Before xmas I need to turn my linux server on a X11box ;)
> 
> happy gaming,
> luca
> 
> follow patch against 2.4.17rc2 inspired from a 1999 alsa-devel post:
> 
> diff -ur linux/Documentation/Configure.help /usr/src/linux/Documentation/Configure.help
> --- linux/Documentation/Configure.help  Wed Dec 19 23:17:07 2001
> +++ /usr/src/linux/Documentation/Configure.help Wed Dec 19 22:11:34 2001
> @@ -18576,7 +18576,7 @@
> 
>  Enable joystick
>  CONFIG_SOUND_CMPCI_JOYSTICK
> -  Say here in order to enable the joystick port on a sound crd using
> +  Say Y here in order to enable the joystick port on a sound card using
>    the CMI8338 or the CMI8738 chipset.  Data on these chips are
>    available at <http://www.cmedia.com.tw/>.
> 
> @@ -18702,6 +18702,11 @@
>    This driver differs slightly from OSS/Free, so PLEASE READ the
>    comments at the top of <file:drivers/sound/trident.c>.
> 
> +Trident Joystick Interface
> +CONFIG_SOUND_TRIDENT_JOYSTICK
> +  Say Y here in order to enable the joystick interface of the 
> +  Trident 4D Wave DX or NX.
> +
>  Rockwell WaveArtist
>  CONFIG_SOUND_WAVEARTIST
>    Say Y here to include support for the Rockwell WaveArtist sound
> diff -ur linux/drivers/sound/Config.in /usr/src/linux/drivers/sound/Config.in
> --- linux/drivers/sound/Config.in       Wed Dec 19 23:17:11 2001
> +++ /usr/src/linux/drivers/sound/Config.in      Wed Dec 19 22:07:55 2001
> @@ -52,7 +52,9 @@
>      dep_tristate '  NEC Vrc5477 AC97 sound' CONFIG_SOUND_VRC5477 $CONFIG_SOUND
>  fi
>  dep_tristate '  Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core' CONFIG_SOUND_TRIDENT $CONFIG_SOUND
> -
> +if [ "$CONFIG_SOUND_TRIDENT" = "y" -o "$CONFIG_SOUND_TRIDENT" = "m" ]; then
> +    bool '    Enable trident joystick port' CONFIG_SOUND_TRIDENT_JOYSTICK
> +fi
>  dep_tristate '  Support for Turtle Beach MultiSound Classic, Tahiti, Monterey' CONFIG_SOUND_MSNDCLAS $CONFIG_SOUND
>  if [ "$CONFIG_SOUND_MSNDCLAS" = "y" -o "$CONFIG_SOUND_MSNDCLAS" = "m" ]; then
>     if [ "$CONFIG_SOUND_MSNDCLAS" = "y" ]; then
> diff -ur linux/drivers/sound/trident.c /usr/src/linux/drivers/sound/trident.c
> --- linux/drivers/sound/trident.c       Mon Dec 17 14:50:31 2001
> +++ /usr/src/linux/drivers/sound/trident.c      Wed Dec 19 23:08:27 2001
> @@ -36,6 +36,10 @@
>   *     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
>   *  History
> + *
> + *  v0.14.9e
> + *     December 20 2001 Luca Montecchiani <m.luca@iname.com>
> + *     enable joystick legacy port on Trident 4Dwave DX/NX
>   *  v0.14.9d
>   *     October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>   *     use set_current_state, properly release resources on failure in
> @@ -180,7 +184,13 @@
> 
>  #include <linux/pm.h>
> 
> -#define DRIVER_VERSION "0.14.9d"
> +#define DRIVER_VERSION "0.14.9e"
> +
> +#ifdef CONFIG_SOUND_TRIDENT_JOYSTICK
> +static  int    joystick = 1;
> +#else
> +static  int    joystick = 0;
> +#endif
> 
>  /* magic numbers to protect our data structures */
>  #define TRIDENT_CARD_MAGIC     0x5072696E /* "Prin" */
> @@ -4070,6 +4080,14 @@
>                 printk(KERN_ERR "trident: couldn't register DSP device!\n");
>                 goto out_free_irq;
>         }
> +
> +       /* enable joystick legacy port by m.luca@iname.com */
> +       if ((card->pci_id == PCI_DEVICE_ID_TRIDENT_4DWAVE_DX ||
> +             card->pci_id == PCI_DEVICE_ID_TRIDENT_4DWAVE_NX) && joystick) {
> +               pci_write_config_byte(pci_dev, 0x44, 0x20);
> +               printk(KERN_INFO "trident: joystick port enabled.\n");
> +       }
> +
>         card->mixer_regs_ready = 0;
>         /* initialize AC97 codec and register /dev/mixer */
>         if (trident_ac97_init(card) <= 0) {
> @@ -4183,6 +4201,8 @@
>         pci_set_drvdata(pci_dev, NULL);
>  }
> 
> +MODULE_PARM(joystick, "i");
> +MODULE_PARM_DESC(joystick, "(1/0) Enable joystick interface, still need joystick driver");
>  MODULE_AUTHOR("Alan Cox, Aaron Holtzman, Ollie Lho, Ching Ling Lee");
>  MODULE_DESCRIPTION("Trident 4DWave/SiS 7018/ALi 5451 and Tvia/IGST CyberPro5050 PCI Audio Driver");
>  MODULE_LICENSE("GPL");
> 
> --
> ----------------------------------------------------------
> Luca Montecchiani <m.luca@iname.com>
> http://www.geocities.com/montecchiani
> SpeakFreely:sflwl -hlwl.fourmilab.ch luca@    ICQ:17655604
> -------------------=(Linux since 1995)=-------------------

-- 
Vojtech Pavlik
SuSE Labs
