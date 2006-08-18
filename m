Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWHRBSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWHRBSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHRBSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:18:42 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:7626 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S932255AbWHRBSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:18:41 -0400
Message-ID: <44E51565.6020505@cc.jyu.fi>
Date: Fri, 18 Aug 2006 04:18:29 +0300
From: lamikr <lamikr@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
User-Agent: Thunderbird 1.5.0.5 (X11/20060804)
MIME-Version: 1.0
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Content-Type: multipart/mixed;
 boundary="------------090300020803020505090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300020803020505090003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add gsm phone support for the mixer in tsc2101 alsa driver. This allows
selecting cellphone for the playback target via alsa mixer interface.
Selection will connect gsm module to speaker and microphone allowing the
user to speak to phone and listen the opponents voice. Tested in ipaq
h63xx by using gomunicator as an application. Tux wanna call home, and
now Tux can finally call home :-)

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>



--------------090300020803020505090003
Content-Type: text/x-patch;
 name*0="0005-add-gsm-phone-support-for-tsc2101-alsa-driver-mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0005-add-gsm-phone-support-for-tsc2101-alsa-driver-mixer.pat";
 filename*1="ch"

From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Fri, 18 Aug 2006 03:15:58 +0300
Subject: [PATCH 5/5] add gsm phone support for the mixer in tsc2101 alsa driver.

Add gsm phone support for the mixer in tsc2101 alsa driver. This allows selecting cellphone for the playback target via alsa mixer interface. Selection will connect gsm module to speaker and microphone allowing the user to speak to phone and listen the opponents voice. Tested in ipaq h63xx by using gomunicator as an application. Tux can now finally call home :-)

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

---
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  290 +++++++++++++++++++++++++++++-
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |    3 
 2 files changed, 286 insertions(+), 7 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 1c7627f..0f92266 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -88,7 +88,6 @@ static void set_record_source(int val)
 	
 	/* Mute Analog Sidetone
 	 * Analog sidetone gain db?
-	 * Cell Phone In not connected to ADC
 	 * Input selected by MICSEL connected to ADC
 	 */
 	data	= MPC_ASTMU | MPC_ASTG(0x45);
@@ -417,6 +416,211 @@ void set_headphone_to_playback_target(vo
 	current_playback_target	= PLAYBACK_TARGET_HEADPHONE;
 }
 
+void set_telephone_to_playback_target(void)
+{
+	/* 
+	 * 0110 1101 0101 1100
+	 * power down MICBIAS_HED, Analog sidetone, SPK2, DAC, 
+	 * Driver virtual ground, loudspeaker. Values D2-d5 are flags.
+	 */	 
+	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
+			CPC_MBIAS_HED | CPC_ASTPWD | CPC_SP2PWDN | CPC_DAPWDN |
+			CPC_VGPWDN | CPC_LSPWDN);
+			
+	/* 
+	 * 0010 1010 0100 0000
+	 * ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
+	 * 1dB AGC hysteresis
+	 * MICes bias 2V
+	 */
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4,
+			AC4_MB_HND | AC4_MB_HED(0) | AC4_AGCHYS(1) | 
+			AC4_BISTPD | AC4_ASSTPD | AC4_DASTPD);
+	printk("set_telephone_to_playback_target(), TSC2101_AUDIO_CTRL_4 = %d\n", omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+			
+	/* 
+	 * 1110 0010 0000 0010
+	 * DAC left and right routed to SPK1/SPK2
+	 * SPK1/SPK2 unmuted
+	 * keyclicks routed to SPK1/SPK2
+	 */	 
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
+			AC5_DIFFIN | AC5_DAC2SPK1(3) | 
+		  	AC5_CPI2SPK1 | AC5_MUTSPK2);
+	
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
+			AC6_MIC2CPO | AC6_MUTLSPK | 
+			AC6_LDSCPTC | AC6_VGNDSCPTC | AC6_CAPINTF);
+	current_playback_target	= PLAYBACK_TARGET_CELLPHONE;
+}
+
+/*
+ * 1100 0101 1101 0000
+ * 
+ * #define MPC_ASTMU           TSC2101_BIT(15)
+ * #define MPC_ASTG(ARG)       (((ARG) & 0x7F) << 8)
+ * #define MPC_MICSEL(ARG)     (((ARG) & 0x07) << 5)
+ * #define MPC_MICADC          TSC2101_BIT(4)
+ * #define MPC_CPADC           TSC2101_BIT(3)
+ * #define MPC_ASTGF           (0x01)
+ */
+static void set_telephone_to_record_source(void)
+{
+	u16	val;
+	
+	/* 
+	 * D0       = 0: 
+	 * 		--> AGC is off for handset input.
+	 *		--> ADC PGA is controlled by the ADMUT_HDN + ADPGA_HND
+	 *          (D15, D14-D8)
+	 * D4 - D1  = 0000 
+	 * 		--> AGC time constant for handset input, 
+	 * 		attack time = 8 mc, decay time = 100 ms
+	 * D7 - D5  = 000
+	 * 		--> AGC Target gain for handset input = -5.5 db
+	 * D14 - D8 = 011 1100
+	 * 		--> ADC handset PGA settings = 60 = 30 db
+	 * D15 		= 0
+	 * 		--> Handset input ON (unmuted)
+	 */
+	val	= 0x3c00;	// 0011 1100 0000 0000 = 60 = 30
+	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
+	
+	/*
+	 * D0		= 0
+	 * 		--> AGC is off for headset/Aux input
+	 * 		--> ADC headset/Aux PGA is contoller by ADMUT_HED + ADPGA_HED
+	 *          (D15, D14-D8)
+	 * D4 - D1	= 0000 
+	 * 		--> Agc constant for headset/Aux input,
+	 *      	attack time = 8 mc, decay time = 100 ms      
+	 * D7 - D5	= 000
+	 * 		--> AGC target gain for headset input = -5.5 db
+	 * D14 - D8 = 000 0000
+	 * 		--> Adc headset/AUX pga settings = 0 db
+	 * D15		= 1
+	 * 		--> Headset/AUX input muted
+	 * 
+	 * Mute headset aux input
+	 */
+	val	= 0x8000;	// 1000 0000 0000 0000
+	omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);
+	set_record_source(REC_SRC_MICIN_HND_AND_AUX1);
+
+	// hacks start
+	/* D0		= flag, Headset/Aux or handset PGA flag
+	 * 		--> & with 1 (= 1 -->gain applied == pga register settings)
+	 * D1		= 0, DAC channel PGA soft stepping control
+	 * 		--> 0.5 db change every WCLK
+	 * D2		= flag, DAC right channel PGA flag
+	 * 		--> & with 1
+	 * D3		= flag, DAC left channel PGA flag
+	 * 		-- > & with 1
+	 * D7 - D4	= 0001, keyclick length
+	 * 		--> 4 periods key clicks
+	 * D10 - D8 = 100, keyclick frequenzy
+	 * 		--> 1 kHz, 
+	 * D11		= 0, Headset/Aux or handset soft stepping control
+	 * 		--> 0,5 db change every WCLK or ADWS
+	 * D14 -D12 = 100, Keyclick applitude control
+	 * 		--> Medium amplitude
+	 * D15		= 0, keyclick disabled
+	 */
+	val	= omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_2);
+	val	= val & 0x441d;
+	val	= val | 0x4410;	// D14, D10, D4 bits == 1
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_2, val);
+
+	/*
+	 * D0		= 0	(reserved, write always 0)
+	 * D1		= flag,
+	 * 			--> & with 1
+	 * D2 - D5	= 0000 (reserved, write always 0000)
+	 * D6		= 1
+	 * 			--> MICBIAS_HND = 2.0 v
+	 * D8 - D7	= 00
+	 * 			--> MICBIAS_HED = 3.3 v
+	 * D10 - D9	= 01, 
+	 * 			--> Mic AGC hysteric selection = 2 db
+	 * D11		= 1, 
+	 * 			--> Disable buzzer PGA soft stepping
+	 * D12		= 0,
+	 * 			--> Enable CELL phone PGA soft stepping control
+	 * D13		= 1
+	 * 			--> Disable analog sidetone soft stepping control
+	 * D14		= 0
+	 * 			--> Enable DAC PGA soft stepping control
+	 * D15		= 0,
+	 * 			--> Enable headset/Aux or Handset soft stepping control
+	 */
+	val	= omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4);
+	val	= val & 0x2a42;	// 0010 1010 0100 0010
+	val	= val | 0x2a40;	// bits D13, D11, D9, D6 == 1
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, val);
+	printk("set_telephone_to_record_source(), TSC2101_AUDIO_CTRL_4 = %d\n", omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+	/*
+	 * D0		= 0
+	 * 		--> reserved, write always = 0
+	 * D1		= flag, read only
+	 * 		--> & with 1
+	 * D5 - D2	= 1111, Buzzer input PGA settings
+	 * 		--> 0 db
+	 * D6		= 1,
+	 * 		--> power down buzzer input pga
+	 * D7		= flag, read only
+	 * 		--> & with 1
+	 * D14 - D8	= 101 1101
+	 * 		--> 12 DB
+	 * D15		= 0
+	 * 		--> power up cell phone input PGA
+	 */
+	val	= omap_tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL);
+	val	= val & 0x5dfe;
+	val	= val | 0x5dfe;	// bits, D14, D12, D11, D10, D8, D6, D5,D4,D3,D2
+	omap_tsc2101_audio_write(TSC2101_BUZZER_GAIN_CTRL, val);
+	
+	/* D6 - D0	= 000 1001
+	 * 		--> -4.5 db for DAC right channel volume control
+	 * D7		= 1
+	 * 		-->  DAC right channel muted
+	 * D14 - D8 = 000 1001
+	 * 		--> -4.5 db for DAC left channel volume control
+	 * D15 		= 1
+	 * 		--> DAC left channel muted
+	 */
+	//val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
+	val	= 0x8989;
+	omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);	
+	
+	/*  0000 0000 0100 0000
+	 * 
+	 * D1 - D0	= 0
+	 * 		--> GPIO 1 pin output is three stated
+	 * D2		= 0
+	 * 		--> Disaple GPIO2 for CLKOUT mode
+	 * D3		= 0
+	 * 		--> Disable GPUI1 for interrupt detection
+	 * D4		= 0
+	 * 		--> Disable GPIO2 for headset detection interrupt
+	 * D5		= reserved, always 0
+	 * D7 - D6	= 01
+	 * 		--> 8 ms clitch detection
+	 * D8		= reserved, write only 0
+	 * D10 -D9	= 00
+	 * 		--> 16 ms de bouncing programmatitily 
+	 *          for glitch detection during headset detection
+	 * D11		= flag for button press
+	 * D12		= flag for headset detection
+	 * D14-D13	= 00
+	 * 		--> type of headset detected = 00 == no stereo headset deected
+	 * D15		= 0
+	 * 		--> Disable headset detection
+	 * 
+	 * */
+	val	= 0x40;
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, val);	
+}
+
 /*
  * Checks whether the headset is detected.
  * If headset is detected, the type is returned. Type can be
@@ -498,7 +702,7 @@ void snd_omap_init_mixer(void)
 static int __pcm_playback_target_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
 {
 	static char *texts[PLAYBACK_TARGET_COUNT] = {
-        	"Loudspeaker", "Headphone"
+        	"Loudspeaker", "Headphone", "Cellphone"
 	};
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -528,12 +732,18 @@ static int __pcm_playback_target_put(snd
 	if ((curVal >= 0) &&
 	    (curVal < PLAYBACK_TARGET_COUNT) &&
 	    (curVal != current_playback_target)) {		
-		if (curVal == 0) {
-			set_loudspeaker_to_playback_target();		
+		if (curVal == PLAYBACK_TARGET_LOUDSPEAKER) {
+			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
+			set_loudspeaker_to_playback_target();
 		}
-		else {
+		else if (curVal == PLAYBACK_TARGET_HEADPHONE) {
+			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HND);
 			set_headphone_to_playback_target();
 		}
+		else if (curVal == PLAYBACK_TARGET_CELLPHONE) {
+			set_telephone_to_record_source();
+			set_telephone_to_playback_target();
+		}
 		retVal	= 1;
 	}
 	return retVal;
@@ -726,6 +936,58 @@ static int __handset_playback_switch_put
 				15);
 }
 
+static int __cellphone_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+/* When BGC_MUT_CP (bit 15) = 1, power down cellphone input pga.
+ * When BGC_MUT_CP = 0, power up cellphone input pga.
+ */
+static int __cellphone_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val = omap_tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_UNMUTED(15, val);
+	return 0;
+}
+
+static int __cellphone_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL,
+				15);	
+}
+
+static int __buzzer_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+/* When BGC_MUT_BU (bit 6) = 1, power down cellphone input pga.
+ * When BGC_MUT_BU = 0, power up cellphone input pga.
+ */
+static int __buzzer_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val = omap_tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_UNMUTED(6, val);
+	return 0;
+}
+
+static int __buzzer_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL,
+				6);	
+}
+
 static snd_kcontrol_new_t tsc2101_control[] __devinitdata = {
 	{
 		.name  = "Target Playback Route",
@@ -783,7 +1045,23 @@ static snd_kcontrol_new_t tsc2101_contro
 		.info  = __handset_playback_switch_info,
 		.get   = __handset_playback_switch_get,
 		.put   = __handset_playback_switch_put,
-	}	
+	}, {
+		.name  = "Cellphone Input Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __cellphone_input_switch_info,
+		.get   = __cellphone_input_switch_get,
+		.put   = __cellphone_input_switch_put,
+	}, {
+		.name  = "Buzzer Input Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __buzzer_input_switch_info,
+		.get   = __buzzer_input_switch_get,
+		.put   = __buzzer_input_switch_put,
+	}
 };
 
 #ifdef CONFIG_PM
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.h b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
index ff852b5..3f27e27 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.h
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
@@ -56,9 +56,10 @@ #define INPUT_VOLUME_MIN 		0x0
 #define INPUT_VOLUME_MAX		0x7D
 #define INPUT_VOLUME_RANGE		(INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
 
-#define PLAYBACK_TARGET_COUNT		0x02
+#define PLAYBACK_TARGET_COUNT		0x03
 #define PLAYBACK_TARGET_LOUDSPEAKER	0x00
 #define PLAYBACK_TARGET_HEADPHONE	0x01
+#define PLAYBACK_TARGET_CELLPHONE	0x02
 
 /* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
 #define REC_SRC_TARGET_COUNT		0x08
-- 
1.4.2


--------------090300020803020505090003--
