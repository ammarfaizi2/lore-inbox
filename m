Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWAPJYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWAPJYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWAPJYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63211 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932295AbWAPJYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:24:33 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 19/25] Separate tv & radio freqs, fix cb/freq transmit
	order for tuners that need this.
Date: Mon, 16 Jan 2006 07:11:24 -0200
Message-id: <20060116091124.PS31858000019@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

- Moved MSP_SET_MATRIX to v4l2-common.h
- Fix typos and integer overflows in tea5767.c
- Split old freq field into a tv_freq and a radio_freq. Prevents
  that a radio tuner is initialized with a tv frequency or vice versa.
- When switching to radio mode initialize the tuner with the last
  used radio frequency (this was already done for the TV mode).
  As a result of these changes the tuner module now remembers the
  last set radio and TV frequencies, which is what you would expect
  to happen.
- Move out of range frequencies to the closest valid frequency as per
  v4l2 API spec.
- Fix incorrect initial radio frequency (multiplier is 16000, not 16)
- Add boundary check for out of range frequencies.
- Use new flag to check if the order of the CB and freq. depends on
  the last set frequency. That is needed for some tuners or you can
  get static as a result. The flag is added for those tuners where I know
  that the datasheet indicates that this is necessary.
- For this new check use the last set div value, not the last frequency
  as radio frequencies are always much higher due to the 16000 multiplier.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/msp3400.h      |    8 ---
 drivers/media/video/mt20xx.c       |   12 +++--
 drivers/media/video/tda8290.c      |    4 +-
 drivers/media/video/tea5767.c      |   18 ++++----
 drivers/media/video/tuner-core.c   |   85 ++++++++++++++++++++++--------------
 drivers/media/video/tuner-simple.c |   44 ++++++++++---------
 drivers/media/video/tuner-types.c  |    6 +++
 drivers/media/video/v4l2-common.c  |    1 
 include/media/tuner-types.h        |   18 ++++++++
 include/media/tuner.h              |    8 ++-
 include/media/v4l2-common.h        |    7 +++
 11 files changed, 129 insertions(+), 82 deletions(-)

diff --git a/drivers/media/video/msp3400.h b/drivers/media/video/msp3400.h
index 70a5ef8..a9ac57d 100644
--- a/drivers/media/video/msp3400.h
+++ b/drivers/media/video/msp3400.h
@@ -6,14 +6,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-struct msp_matrix {
-  int input;
-  int output;
-};
-
-/* ioctl for MSP_SET_MATRIX will have to be registered */
-#define MSP_SET_MATRIX     _IOW('m',17,struct msp_matrix)
-
 /* This macro is allowed for *constants* only, gcc must calculate it
    at compile time.  Remember -- no floats in kernel mode */
 #define MSP_CARRIER(freq) ((int)((float)(freq / 18.432) * (1 << 24)))
diff --git a/drivers/media/video/mt20xx.c b/drivers/media/video/mt20xx.c
index 0bf1caa..c7c9f3f 100644
--- a/drivers/media/video/mt20xx.c
+++ b/drivers/media/video/mt20xx.c
@@ -353,8 +353,8 @@ static int mt2032_init(struct i2c_client
 	} while (xok != 1 );
 	t->xogc=xogc;
 
-	t->tv_freq    = mt2032_set_tv_freq;
-	t->radio_freq = mt2032_set_radio_freq;
+	t->set_tv_freq    = mt2032_set_tv_freq;
+	t->set_radio_freq = mt2032_set_radio_freq;
 	return(1);
 }
 
@@ -481,8 +481,8 @@ static int mt2050_init(struct i2c_client
 	i2c_master_recv(c,buf,1);
 
 	tuner_dbg("mt2050: sro is %x\n",buf[0]);
-	t->tv_freq    = mt2050_set_tv_freq;
-	t->radio_freq = mt2050_set_radio_freq;
+	t->set_tv_freq    = mt2050_set_tv_freq;
+	t->set_radio_freq = mt2050_set_radio_freq;
 	return 0;
 }
 
@@ -494,8 +494,8 @@ int microtune_init(struct i2c_client *c)
 	int company_code;
 
 	memset(buf,0,sizeof(buf));
-	t->tv_freq    = NULL;
-	t->radio_freq = NULL;
+	t->set_tv_freq    = NULL;
+	t->set_radio_freq = NULL;
 	t->standby    = NULL;
 	if (t->std & V4L2_STD_525_60) {
 		tuner_dbg("pinnacle ntsc\n");
diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
index 2498b76..7b4fb28 100644
--- a/drivers/media/video/tda8290.c
+++ b/drivers/media/video/tda8290.c
@@ -567,8 +567,8 @@ int tda8290_init(struct i2c_client *c)
 	}
 	tuner_info("tuner: type set to %s\n", c->name);
 
-	t->tv_freq    = set_tv_freq;
-	t->radio_freq = set_radio_freq;
+	t->set_tv_freq    = set_tv_freq;
+	t->set_radio_freq = set_radio_freq;
 	t->has_signal = has_signal;
 	t->standby = standby;
 	t->tda827x_lpsel = 0;
diff --git a/drivers/media/video/tea5767.c b/drivers/media/video/tea5767.c
index 921fe72..c2b98f8 100644
--- a/drivers/media/video/tea5767.c
+++ b/drivers/media/video/tea5767.c
@@ -62,7 +62,7 @@ extern int tuner_debug;
 
 #define TEA5767_PORT1_HIGH	0x01
 
-/* Forth register */
+/* Fourth register */
 #define TEA5767_PORT2_HIGH	0x80
 /* Chips stops working. Only I2C bus remains on */
 #define TEA5767_STDBY		0x40
@@ -85,7 +85,7 @@ extern int tuner_debug;
 /* If activate PORT 1 indicates SEARCH or else it is used as PORT1 */
 #define TEA5767_SRCH_IND	0x01
 
-/* Fiveth register */
+/* Fifth register */
 
 /* By activating, it will use Xtal at 13 MHz as reference for divider */
 #define TEA5767_PLLREF_ENABLE	0x80
@@ -109,13 +109,13 @@ extern int tuner_debug;
 #define TEA5767_STEREO_MASK	0x80
 #define TEA5767_IF_CNTR_MASK	0x7f
 
-/* Four register */
+/* Fourth register */
 #define TEA5767_ADC_LEVEL_MASK	0xf0
 
 /* should be 0 */
 #define TEA5767_CHIP_ID_MASK	0x0f
 
-/* Fiveth register */
+/* Fifth register */
 /* Reserved for future extensions */
 #define TEA5767_RESERVED_MASK	0xff
 
@@ -220,19 +220,19 @@ static void set_radio_freq(struct i2c_cl
 		tuner_dbg ("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
 		buffer[2] |= TEA5767_HIGH_LO_INJECT;
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq * 4000 / 16 + 700000 + 225000 + 25000) / 50000;
+		div = (frq * (4000 / 16) + 700000 + 225000 + 25000) / 50000;
 		break;
 	case TEA5767_LOW_LO_13MHz:
 		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
 
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq * 4000 / 16 - 700000 - 225000 + 25000) / 50000;
+		div = (frq * (4000 / 16) - 700000 - 225000 + 25000) / 50000;
 		break;
 	case TEA5767_LOW_LO_32768:
 		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
 		buffer[3] |= TEA5767_XTAL_32768;
 		/* const 700=4000*175 Khz - to adjust freq to right value */
-		div = ((frq * 4000 / 16 - 700000 - 225000) + 16384) >> 15;
+		div = ((frq * (4000 / 16) - 700000 - 225000) + 16384) >> 15;
 		break;
 	case TEA5767_HIGH_LO_32768:
 	default:
@@ -350,8 +350,8 @@ int tea5767_tuner_init(struct i2c_client
 	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
 	strlcpy(c->name, "tea5767", sizeof(c->name));
 
-	t->tv_freq = set_tv_freq;
-	t->radio_freq = set_radio_freq;
+	t->set_tv_freq = set_tv_freq;
+	t->set_radio_freq = set_radio_freq;
 	t->has_signal = tea5767_signal;
 	t->is_stereo = tea5767_stereo;
 	t->standby = tea5767_standby;
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index f30ef79..2995b22 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -82,7 +82,7 @@ static void set_tv_freq(struct i2c_clien
 		tuner_warn ("tuner type not set\n");
 		return;
 	}
-	if (NULL == t->tv_freq) {
+	if (NULL == t->set_tv_freq) {
 		tuner_warn ("Tuner has no way to set tv freq\n");
 		return;
 	}
@@ -90,8 +90,14 @@ static void set_tv_freq(struct i2c_clien
 		tuner_dbg ("TV freq (%d.%02d) out of range (%d-%d)\n",
 			   freq / 16, freq % 16 * 100 / 16, tv_range[0],
 			   tv_range[1]);
+		/* V4L2 spec: if the freq is not possible then the closest
+		   possible value should be selected */
+		if (freq < tv_range[0] * 16)
+			freq = tv_range[0] * 16;
+		else
+			freq = tv_range[1] * 16;
 	}
-	t->tv_freq(c, freq);
+	t->set_tv_freq(c, freq);
 }
 
 static void set_radio_freq(struct i2c_client *c, unsigned int freq)
@@ -102,18 +108,23 @@ static void set_radio_freq(struct i2c_cl
 		tuner_warn ("tuner type not set\n");
 		return;
 	}
-	if (NULL == t->radio_freq) {
+	if (NULL == t->set_radio_freq) {
 		tuner_warn ("tuner has no way to set radio frequency\n");
 		return;
 	}
-	if (freq <= radio_range[0] * 16000 || freq >= radio_range[1] * 16000) {
+	if (freq < radio_range[0] * 16000 || freq > radio_range[1] * 16000) {
 		tuner_dbg ("radio freq (%d.%02d) out of range (%d-%d)\n",
 			   freq / 16000, freq % 16000 * 100 / 16000,
 			   radio_range[0], radio_range[1]);
+		/* V4L2 spec: if the freq is not possible then the closest
+		   possible value should be selected */
+		if (freq < radio_range[0] * 16000)
+			freq = radio_range[0] * 16000;
+		else
+			freq = radio_range[1] * 16000;
 	}
 
-	t->radio_freq(c, freq);
-	return;
+	t->set_radio_freq(c, freq);
 }
 
 static void set_freq(struct i2c_client *c, unsigned long freq)
@@ -125,15 +136,16 @@ static void set_freq(struct i2c_client *
 		tuner_dbg("radio freq set to %lu.%02lu\n",
 			  freq / 16000, freq % 16000 * 100 / 16000);
 		set_radio_freq(c, freq);
+		t->radio_freq = freq;
 		break;
 	case V4L2_TUNER_ANALOG_TV:
 	case V4L2_TUNER_DIGITAL_TV:
 		tuner_dbg("tv freq set to %lu.%02lu\n",
 			  freq / 16, freq % 16 * 100 / 16);
 		set_tv_freq(c, freq);
+		t->tv_freq = freq;
 		break;
 	}
-	t->freq = freq;
 }
 
 static void set_type(struct i2c_client *c, unsigned int type,
@@ -212,7 +224,7 @@ static void set_type(struct i2c_client *
 	if (t->mode_mask == T_UNINITIALIZED)
 		t->mode_mask = new_mode_mask;
 
-	set_freq(c, t->freq);
+	set_freq(c, (V4L2_TUNER_RADIO == t->mode) ? t->radio_freq : t->tv_freq);
 	tuner_dbg("%s %s I2C addr 0x%02x with type %d used for 0x%02x\n",
 		  c->adapter->name, c->driver->driver.name, c->addr << 1, type,
 		  t->mode_mask);
@@ -377,11 +389,11 @@ static void tuner_status(struct i2c_clie
 		default: p = "undefined"; break;
 	}
 	if (t->mode == V4L2_TUNER_RADIO) {
-		freq = t->freq / 16000;
-		freq_fraction = (t->freq % 16000) * 100 / 16000;
+		freq = t->radio_freq / 16000;
+		freq_fraction = (t->radio_freq % 16000) * 100 / 16000;
 	} else {
-		freq = t->freq / 16;
-		freq_fraction = (t->freq % 16) * 100 / 16;
+		freq = t->tv_freq / 16;
+		freq_fraction = (t->tv_freq % 16) * 100 / 16;
 	}
 	tuner_info("Tuner mode:      %s\n", p);
 	tuner_info("Frequency:       %lu.%02lu MHz\n", freq, freq_fraction);
@@ -456,7 +468,7 @@ static int tuner_attach(struct i2c_adapt
 				t->type = TUNER_TEA5767;
 				t->mode_mask = T_RADIO;
 				t->mode = T_STANDBY;
-				t->freq = 87.5 * 16; /* Sets freq to FM range */
+				t->radio_freq = 87.5 * 16000; /* Sets freq to FM range */
 				default_mode_mask &= ~T_RADIO;
 
 				goto register_client;
@@ -469,7 +481,8 @@ static int tuner_attach(struct i2c_adapt
 	if (default_mode_mask != T_UNINITIALIZED) {
 		tuner_dbg ("Setting mode_mask to 0x%02x\n", default_mode_mask);
 		t->mode_mask = default_mode_mask;
-		t->freq = 400 * 16; /* Sets freq to VHF High */
+		t->tv_freq = 400 * 16; /* Sets freq to VHF High */
+		t->radio_freq = 87.5 * 16000; /* Sets freq to FM range */
 		default_mode_mask = T_UNINITIALIZED;
 	}
 
@@ -565,16 +578,18 @@ static int tuner_command(struct i2c_clie
 		set_addr(client, (struct tuner_setup *)arg);
 		break;
 	case AUDC_SET_RADIO:
-		set_mode(client,t,V4L2_TUNER_RADIO, "AUDC_SET_RADIO");
+		if (set_mode(client, t, V4L2_TUNER_RADIO, "AUDC_SET_RADIO")
+				== EINVAL)
+			return 0;
+		if (t->radio_freq)
+			set_freq(client, t->radio_freq);
 		break;
 	case TUNER_SET_STANDBY:
-		{
-			if (check_mode(t, "TUNER_SET_STANDBY") == EINVAL)
-				return 0;
-			if (t->standby)
-				t->standby (client);
-			break;
-		}
+		if (check_mode(t, "TUNER_SET_STANDBY") == EINVAL)
+			return 0;
+		if (t->standby)
+			t->standby (client);
+		break;
 	case VIDIOCSAUDIO:
 		if (check_mode(t, "VIDIOCSAUDIO") == EINVAL)
 			return 0;
@@ -583,7 +598,6 @@ static int tuner_command(struct i2c_clie
 
 		/* Should be implemented, since bttv calls it */
 		tuner_dbg("VIDIOCSAUDIO not implemented.\n");
-
 		break;
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
@@ -609,8 +623,8 @@ static int tuner_command(struct i2c_clie
 			if (vc->norm < ARRAY_SIZE(map))
 				t->std = map[vc->norm];
 			tuner_fixup_std(t);
-			if (t->freq)
-				set_tv_freq(client, t->freq);
+			if (t->tv_freq)
+				set_tv_freq(client, t->tv_freq);
 			return 0;
 		}
 	case VIDIOCSFREQ:
@@ -684,15 +698,14 @@ static int tuner_command(struct i2c_clie
 
 			t->std = *id;
 			tuner_fixup_std(t);
-			if (t->freq)
-				set_freq(client, t->freq);
+			if (t->tv_freq)
+				set_freq(client, t->tv_freq);
 			break;
 		}
 	case VIDIOC_S_FREQUENCY:
 		{
 			struct v4l2_frequency *f = arg;
 
-			t->freq = f->frequency;
 			switch_v4l2();
 			if (V4L2_TUNER_RADIO == f->type &&
 			    V4L2_TUNER_RADIO != t->mode) {
@@ -700,7 +713,7 @@ static int tuner_command(struct i2c_clie
 					    == EINVAL)
 					return 0;
 			}
-			set_freq(client,t->freq);
+			set_freq(client,f->frequency);
 
 			break;
 		}
@@ -712,7 +725,8 @@ static int tuner_command(struct i2c_clie
 				return 0;
 			switch_v4l2();
 			f->type = t->mode;
-			f->frequency = t->freq;
+			f->frequency = (V4L2_TUNER_RADIO == t->mode) ?
+				t->radio_freq : t->tv_freq;
 			break;
 		}
 	case VIDIOC_G_TUNER:
@@ -763,7 +777,7 @@ static int tuner_command(struct i2c_clie
 
 			if (V4L2_TUNER_RADIO == t->mode) {
 				t->audmode = tuner->audmode;
-				set_radio_freq(client, t->freq);
+				set_radio_freq(client, t->radio_freq);
 			}
 			break;
 		}
@@ -791,8 +805,13 @@ static int tuner_resume(struct device *d
 	struct tuner *t = i2c_get_clientdata (c);
 
 	tuner_dbg ("resume\n");
-	if (t->freq)
-		set_freq(c, t->freq);
+	if (V4L2_TUNER_RADIO == t->mode) {
+		if (t->radio_freq)
+			set_freq(c, t->radio_freq);
+	} else {
+		if (t->tv_freq)
+			set_freq(c, t->tv_freq);
+	}
 	return 0;
 }
 
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 3879262..37977ff 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -136,7 +136,7 @@ static void default_set_tv_freq(struct i
 	u8 config, tuneraddr;
 	u16 div;
 	struct tunertype *tun;
-	unsigned char buffer[4];
+	u8 buffer[4];
 	int rc, IFPCoff, i, j;
 
 	tun = &tuners[t->type];
@@ -147,6 +147,11 @@ static void default_set_tv_freq(struct i
 			continue;
 		break;
 	}
+	if (i == tun->params[j].count) {
+		tuner_dbg("TV frequency out of range (%d > %d)",
+				freq, tun->params[j].ranges[i - 1].limit);
+		freq = tun->params[j].ranges[--i].limit;
+	}
 	config = tun->params[j].ranges[i].cb;
 	/*  i == 0 -> VHF_LO  */
 	/*  i == 1 -> VHF_HI  */
@@ -239,20 +244,6 @@ static void default_set_tv_freq(struct i
 		break;
 	}
 
-	/*
-	 * Philips FI1216MK2 remark from specification :
-	 * for channel selection involving band switching, and to ensure
-	 * smooth tuning to the desired channel without causing
-	 * unnecessary charge pump action, it is recommended to consider
-	 * the difference between wanted channel frequency and the
-	 * current channel frequency.  Unnecessary charge pump action
-	 * will result in very low tuning voltage which may drive the
-	 * oscillator to extreme conditions.
-	 *
-	 * Progfou: specification says to send config data before
-	 * frequency in case (wanted frequency < current frequency).
-	 */
-
 	/* IFPCoff = Video Intermediate Frequency - Vif:
 		940  =16*58.75  NTSC/J (Japan)
 		732  =16*45.75  M/N STD
@@ -284,7 +275,7 @@ static void default_set_tv_freq(struct i
 					offset / 16, offset % 16 * 100 / 16,
 					div);
 
-	if (t->type == TUNER_PHILIPS_SECAM && freq < t->freq) {
+	if (tuners[t->type].params->cb_first_if_lower_freq && div < t->last_div) {
 		buffer[0] = tun->params[j].config;
 		buffer[1] = config;
 		buffer[2] = (div>>8) & 0x7f;
@@ -295,6 +286,7 @@ static void default_set_tv_freq(struct i
 		buffer[2] = tun->params[j].config;
 		buffer[3] = config;
 	}
+	t->last_div = div;
 	tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		  buffer[0],buffer[1],buffer[2],buffer[3]);
 
@@ -337,8 +329,8 @@ static void default_set_radio_freq(struc
 {
 	struct tunertype *tun;
 	struct tuner *t = i2c_get_clientdata(c);
-	unsigned char buffer[4];
-	unsigned div;
+	u8 buffer[4];
+	u16 div;
 	int rc, j;
 
 	tun = &tuners[t->type];
@@ -374,9 +366,19 @@ static void default_set_radio_freq(struc
 	}
 	buffer[0] = (div>>8) & 0x7f;
 	buffer[1] = div      & 0xff;
+	if (tuners[t->type].params->cb_first_if_lower_freq && div < t->last_div) {
+		buffer[0] = buffer[2];
+		buffer[1] = buffer[3];
+		buffer[2] = (div>>8) & 0x7f;
+		buffer[3] = div      & 0xff;
+	} else {
+		buffer[0] = (div>>8) & 0x7f;
+		buffer[1] = div      & 0xff;
+	}
 
 	tuner_dbg("radio 0x%02x 0x%02x 0x%02x 0x%02x\n",
 	       buffer[0],buffer[1],buffer[2],buffer[3]);
+	t->last_div = div;
 
 	if (4 != (rc = i2c_master_send(c,buffer,4)))
 		tuner_warn("i2c i/o error: rc == %d (should be 4)\n",rc);
@@ -390,10 +392,10 @@ int default_tuner_init(struct i2c_client
 		   t->type, tuners[t->type].name);
 	strlcpy(c->name, tuners[t->type].name, sizeof(c->name));
 
-	t->tv_freq    = default_set_tv_freq;
-	t->radio_freq = default_set_radio_freq;
+	t->set_tv_freq = default_set_tv_freq;
+	t->set_radio_freq = default_set_radio_freq;
 	t->has_signal = tuner_signal;
-	t->is_stereo  = tuner_stereo;
+	t->is_stereo = tuner_stereo;
 	t->standby = NULL;
 
 	return 0;
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 32c9be4..6fe7817 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -81,6 +81,7 @@ static struct tuner_params tuner_philips
 		.ranges = tuner_philips_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_ntsc_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
@@ -98,6 +99,7 @@ static struct tuner_params tuner_philips
 		.ranges = tuner_philips_secam_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_secam_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
@@ -115,6 +117,7 @@ static struct tuner_params tuner_philips
 		.ranges = tuner_philips_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_pal_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
@@ -596,6 +599,7 @@ static struct tuner_params tuner_fm1216m
 		.ranges = tuner_fm1216me_mk3_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_fm1216me_mk3_pal_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
@@ -670,6 +674,7 @@ static struct tuner_params tuner_fm1236_
 		.ranges = tuner_fm1236_mk3_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
@@ -784,6 +789,7 @@ static struct tuner_params tuner_tcl_200
 		.ranges = tuner_tcl_2002n_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_tcl_2002n_ntsc_ranges),
 		.config = 0x8e,
+		.cb_first_if_lower_freq = 1,
 	},
 };
 
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index 5dbd7c1..cd2c447 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -306,6 +306,7 @@ static const char *v4l2_int_ioctls[] = {
 #endif
 	[_IOC_NR(AUDC_SET_RADIO)]              = "AUDC_SET_RADIO",
 	[_IOC_NR(AUDC_SET_INPUT)]              = "AUDC_SET_INPUT",
+	[_IOC_NR(MSP_SET_MATRIX)]              = "MSP_SET_MATRIX",
 
 	[_IOC_NR(TUNER_SET_TYPE_ADDR)]         = "TUNER_SET_TYPE_ADDR",
 	[_IOC_NR(TUNER_SET_STANDBY)]           = "TUNER_SET_STANDBY",
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 7566931..b37d59d 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -20,6 +20,24 @@ struct tuner_range {
 struct tuner_params {
 	enum param_type type;
 	unsigned int tda988x;
+	/* Many Philips based tuners have a comment like this in their
+	 * datasheet:
+	 *
+	 *   For channel selection involving band switching, and to ensure
+	 *   smooth tuning to the desired channel without causing
+	 *   unnecessary charge pump action, it is recommended to consider
+	 *   the difference between wanted channel frequency and the
+	 *   current channel frequency.  Unnecessary charge pump action
+	 *   will result in very low tuning voltage which may drive the
+	 *   oscillator to extreme conditions.
+	 *
+	 * Set this flag to 1 if this tuner needs this check.
+	 *
+	 * I tested this for PAL by first setting the TV frequency to
+	 * 203 MHz and then switching to 96.6 MHz FM radio. The result was
+	 * static unless the control byte was sent first.
+	 */
+	unsigned int cb_first_if_lower_freq:1;
 	unsigned char config; /* to be moved into struct tuner_range for dvb-pll merge */
 
 	unsigned int count;
diff --git a/include/media/tuner.h b/include/media/tuner.h
index a1d6378..a5beeac 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -179,7 +179,9 @@ struct tuner {
 	unsigned int mode;
 	unsigned int mode_mask;	/* Combination of allowable modes */
 
-	unsigned int freq;	/* keep track of the current settings */
+	unsigned int tv_freq;	/* keep track of the current settings */
+	unsigned int radio_freq;
+	u16 	     last_div;
 	unsigned int audmode;
 	v4l2_std_id  std;
 
@@ -197,8 +199,8 @@ struct tuner {
 	unsigned int sgIF;
 
 	/* function ptrs */
-	void (*tv_freq)(struct i2c_client *c, unsigned int freq);
-	void (*radio_freq)(struct i2c_client *c, unsigned int freq);
+	void (*set_tv_freq)(struct i2c_client *c, unsigned int freq);
+	void (*set_radio_freq)(struct i2c_client *c, unsigned int freq);
 	int  (*has_signal)(struct i2c_client *c);
 	int  (*is_stereo)(struct i2c_client *c);
 	void (*standby)(struct i2c_client *c);
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index c74052a..d4030a7 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -120,6 +120,13 @@ enum v4l2_chip_ident {
 /* select from TV,radio,extern,MUTE */
 #define AUDC_SET_INPUT        _IOW('d',89,int)
 
+/* msp3400 ioctl: will be removed in the near future */
+struct msp_matrix {
+  int input;
+  int output;
+};
+#define MSP_SET_MATRIX     _IOW('m',17,struct msp_matrix)
+
 /* tuner ioctls */
 /* Sets tuner type and its I2C addr */
 #define TUNER_SET_TYPE_ADDR          _IOW('d',90,int)

