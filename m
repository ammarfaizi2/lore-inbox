Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbRERSIl>; Fri, 18 May 2001 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbRERSIb>; Fri, 18 May 2001 14:08:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59406 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261314AbRERSIW>; Fri, 18 May 2001 14:08:22 -0400
Date: Fri, 18 May 2001 15:08:17 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        virii <virii@gcecisp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: cmpci sound chip lockup
Message-ID: <20010518150817.O1414@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rik van Riel <riel@conectiva.com.br>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	virii <virii@gcecisp.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010517135808.G754@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.33.0105181501590.5251-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0105181501590.5251-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, May 18, 2001 at 03:02:18PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 18, 2001 at 03:02:18PM -0300, Rik van Riel escreveu:
> On Thu, 17 May 2001, Ingo Oeser wrote:
> > On Wed, May 16, 2001 at 08:02:06PM -0300, Rik van Riel wrote:
> > > I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
> > > serious way. Using xmms the music stops after anything between
> > > a few seconds and a minute, I suspect a race condition somewhere.
> > >
> > > Using mpg123 everything works fine...
> >
> > Your xmms uses esd[1]?
> 
> Nope. I also get this with xmms directly to /dev/dsp.

Can you try this patch? some parts are just some cleanups, but there are
two bugs fixed, this was just a quick look, maybe there are other bugs.

- Arnaldo

--- linux-2.4.4-ac11/drivers/sound/cmpci.c	Fri May 18 00:04:23 2001
+++ linux-2.4.4-ac11.acme/drivers/sound/cmpci.c	Fri May 18 01:03:22 2001
@@ -70,6 +70,12 @@
  *                     (8738 only)
  *                     Fix bug cause x11amp cannot play.
  *
+ *    Fixes:
+ *    Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *    18/05/2001 - .bss nitpicks, fix a bug in set_dac_channels where it
+ *    		   was calling prog_dmabuf with s->lock held, call missing
+ *    		   unlock_kernel in cm_midi_release
+ *
  */
 
 /*****************************************************************************/
@@ -335,9 +341,9 @@
 
 /* --------------------------------------------------------------------- */
 
-static struct cm_state *devs = NULL;
-static struct cm_state *devaudio = NULL;
-static unsigned long wavetable_mem = 0;
+static struct cm_state *devs;
+static struct cm_state *devaudio;
+static unsigned long wavetable_mem;
 
 /* --------------------------------------------------------------------- */
 
@@ -862,8 +868,10 @@
 		maskb(s->iobase + CODEC_CMI_MISC_CTRL + 2, ~0, 0xC0);
 		s->status |= DO_DUAL_DAC;
 		// prepare secondary buffer
+		spin_unlock_irqrestore(&s->lock, flags);
 		ret = prog_dmabuf(s, 1);
 		if (ret) return ret;
+		spin_lock_irqsave(&s->lock, flags);
 		// copy the hw state
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_DACSHIFT);
 		fmtm &= ~((CM_CFMT_STEREO | CM_CFMT_16BIT) << CM_CFMT_ADCSHIFT);
@@ -2578,6 +2586,7 @@
 			if (file->f_flags & O_NONBLOCK) {
 				remove_wait_queue(&s->midi.owait, &wait);
 				set_current_state(TASK_RUNNING);
+				unlock_kernel();
 				return -EBUSY;
 			}
 			tmo = (count * HZ) / 3100;
@@ -2710,10 +2719,8 @@
 		outb(5, s->iosynth+2);
 		outb(arg & 1, s->iosynth+3);
 		return 0;
-
-	default:
-		return -EINVAL;
 	}
+	return -EINVAL;
 }
 
 static int cm_dmfm_open(struct inode *inode, struct file *file)
@@ -2859,22 +2866,22 @@
 #ifdef CONFIG_SOUND_CMPCI_MIDI
 static	int	mpu_io = CONFIG_SOUND_CMPCI_MPUIO;
 #else
-static	int	mpu_io = 0;
+static	int	mpu_io;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_FM
 static	int	fm_io = CONFIG_SOUND_CMPCI_FMIO;
 #else
-static	int	fm_io = 0;
+static	int	fm_io;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_SPDIFINVERSE
 static	int	spdif_inverse = 1;
 #else
-static	int	spdif_inverse = 0;
+static	int	spdif_inverse;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_SPDIFLOOP
 static	int	spdif_loop = 1;
 #else
-static	int	spdif_loop = 0;
+static	int	spdif_loop;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_SPEAKERS
 static	int	speakers = CONFIG_SOUND_CMPCI_SPEAKERS;
@@ -2884,17 +2891,17 @@
 #ifdef CONFIG_SOUND_CMPCI_LINE_REAR
 static	int	use_line_as_rear = 1;
 #else
-static	int	use_line_as_rear = 0;
+static	int	use_line_as_rear;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_LINE_BASS
 static	int	use_line_as_bass = 1;
 #else
-static	int	use_line_as_bass = 0;
+static	int	use_line_as_bass;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_JOYSTICK
 static	int	joystick = 1;
 #else
-static	int	joystick = 0;
+static	int	joystick;
 #endif
 MODULE_PARM(mpu_io, "i");
 MODULE_PARM(fm_io, "i");
@@ -2935,7 +2942,8 @@
 			return;
 		if (pcidev->irq == 0)
 			return;
-		if (!(s = kmalloc(sizeof(struct cm_state), GFP_KERNEL))) {
+		s = kmalloc(sizeof(*s), GFP_KERNEL);
+		if (!s) {
 			printk(KERN_WARNING "cm: out of memory\n");
 			return;
 		}
