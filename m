Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTDGXgq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTDGXed (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:34:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7297
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263795AbTDGXPP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:15:15 -0400
Date: Tue, 8 Apr 2003 01:34:05 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080034.h380Y5Qs009218@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update dvb headers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/audio.h linux-2.5.67-ac1/include/linux/dvb/audio.h
--- linux-2.5.67/include/linux/dvb/audio.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/audio.h	2003-04-07 21:17:58.000000000 +0100
@@ -47,10 +47,17 @@
 typedef enum {
         AUDIO_STEREO,
         AUDIO_MONO_LEFT, 
-	AUDIO_MONO_RIGHT, 
+	AUDIO_MONO_RIGHT 
 } audio_channel_select_t;
 
 
+typedef struct audio_mixer { 
+        unsigned int volume_left;
+        unsigned int volume_right;
+  // what else do we need? bass, pass-through, ...
+} audio_mixer_t;
+
+
 typedef struct audio_status { 
         int                    AV_sync_state;  /* sync audio and video? */
         int                    mute_state;     /* audio is muted */ 
@@ -58,16 +65,10 @@
         audio_stream_source_t  stream_source;  /* current stream source */
         audio_channel_select_t channel_select; /* currently selected channel */
         int                    bypass_mode;    /* pass on audio data to */
+	audio_mixer_t	       mixer_state;    /* current mixer state */
 } audio_status_t;                              /* separate decoder hardware */
 
 
-typedef struct audio_mixer { 
-        unsigned int volume_left;
-        unsigned int volume_right;
-  // what else do we need? bass, pass-through, ...
-} audio_mixer_t;
-
-
 typedef
 struct audio_karaoke{  /* if Vocal1 or Vocal2 are non-zero, they get mixed  */
 	int vocal1;    /* into left and right t at 70% each */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/ca.h linux-2.5.67-ac1/include/linux/dvb/ca.h
--- linux-2.5.67/include/linux/dvb/ca.h	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/ca.h	2003-04-07 21:17:58.000000000 +0100
@@ -21,8 +21,8 @@
  *
  */
 
-#ifndef _CA_H_
-#define _CA_H_
+#ifndef _DVBCA_H_
+#define _DVBCA_H_
 
 /* slot interface types and info */
 
@@ -33,6 +33,7 @@
 #define CA_CI            1     /* CI high level interface */
 #define CA_CI_LINK       2     /* CI link layer level interface */
 #define CA_CI_PHYS       4     /* CI physical layer level interface */
+#define CA_DESCR         8     /* built-in descrambler */
 #define CA_SC          128     /* simple smart card interface */
 
         unsigned int flags;
@@ -44,7 +45,7 @@
 /* descrambler types and info */
 
 typedef struct ca_descr_info {
-        unsigned int num;          /* number of available descramblers (keys) */ 
+        unsigned int num;          /* number of available descramblers (keys) */
         unsigned int type;         /* type of supported scrambling system */
 #define CA_ECD           1
 #define CA_NDS           2
@@ -59,19 +60,24 @@
 } ca_caps_t;
 
 /* a message to/from a CI-CAM */
-typedef struct ca_msg {   
-        unsigned int index;         
+typedef struct ca_msg {
+        unsigned int index;
         unsigned int type;
         unsigned int length;
         unsigned char msg[256];
 } ca_msg_t;
 
 typedef struct ca_descr {
-        unsigned int index;    
-        unsigned int parity;
+        unsigned int index;
+        unsigned int parity;	/* 0 == even, 1 == odd */
         unsigned char cw[8];
 } ca_descr_t;
 
+typedef struct ca_pid {
+        unsigned int pid;
+        int index;		/* -1 == disable*/
+} ca_pid_t;
+
 #define CA_RESET          _IO('o', 128)
 #define CA_GET_CAP        _IOR('o', 129, ca_caps_t)
 #define CA_GET_SLOT_INFO  _IOR('o', 130, ca_slot_info_t)
@@ -79,6 +85,7 @@
 #define CA_GET_MSG        _IOR('o', 132, ca_msg_t)
 #define CA_SEND_MSG       _IOW('o', 133, ca_msg_t)
 #define CA_SET_DESCR      _IOW('o', 134, ca_descr_t)
+#define CA_SET_PID        _IOW('o', 135, ca_pid_t)
 
 #endif
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/dmx.h linux-2.5.67-ac1/include/linux/dvb/dmx.h
--- linux-2.5.67/include/linux/dvb/dmx.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/dmx.h	2003-04-07 21:17:58.000000000 +0100
@@ -21,13 +21,14 @@
  *
  */
 
-#ifndef _DMX_H_
-#define _DMX_H_
+#ifndef _DVBDMX_H_
+#define _DVBDMX_H_
 
 #ifdef __KERNEL__
 #include <linux/types.h>
 #else
 #include <stdint.h>
+#include <time.h>
 #endif
 
 #define DMX_FILTER_SIZE 16
@@ -154,9 +155,15 @@
 	DMX_SOURCE_DVR0   = 16,
 	DMX_SOURCE_DVR1,
 	DMX_SOURCE_DVR2,
-	DMX_SOURCE_DVR3,
+	DMX_SOURCE_DVR3
 } dmx_source_t;
 
+struct dmx_stc {
+	unsigned int num;	/* input : which STC? 0..N */
+	unsigned int base;	/* output: divisor for stc to get 90 kHz clock */
+	uint64_t stc;		/* output: stc in 'base'*90 kHz units */
+};
+
 
 #define DMX_START                _IO('o',41) 
 #define DMX_STOP                 _IO('o',42)
@@ -164,9 +171,10 @@
 #define DMX_SET_PES_FILTER       _IOW('o',44,struct dmx_pes_filter_params)
 #define DMX_SET_BUFFER_SIZE      _IO('o',45)
 #define DMX_GET_EVENT            _IOR('o',46,struct dmx_event)
-#define DMX_GET_PES_PIDS         _IOR('o',47,uint16_t)
+#define DMX_GET_PES_PIDS         _IOR('o',47,uint16_t[5])
 #define DMX_GET_CAPS             _IOR('o',48,dmx_caps_t)
 #define DMX_SET_SOURCE           _IOW('o',49,dmx_source_t)
+#define DMX_GET_STC              _IOWR('o',50,struct dmx_stc)
 
-#endif /*_DMX_H_*/
+#endif /*_DVBDMX_H_*/
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/frontend.h linux-2.5.67-ac1/include/linux/dvb/frontend.h
--- linux-2.5.67/include/linux/dvb/frontend.h	2003-02-10 18:38:31.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/frontend.h	2003-04-07 21:17:58.000000000 +0100
@@ -23,8 +23,8 @@
  *
  */
 
-#ifndef _FRONTEND_H_
-#define _FRONTEND_H_
+#ifndef _DVBFRONTEND_H_
+#define _DVBFRONTEND_H_
 
 #ifdef __KERNEL__
 #include <linux/types.h>
@@ -33,14 +33,14 @@
 #endif
 
 
-typedef enum {
+typedef enum fe_type {
         FE_QPSK,
         FE_QAM,
         FE_OFDM
 } fe_type_t;
 
 
-typedef enum {
+typedef enum fe_caps {
 	FE_IS_STUPID                  = 0,
 	FE_CAN_INVERSION_AUTO         = 0x1,
 	FE_CAN_FEC_1_2                = 0x2,
@@ -63,6 +63,8 @@
 	FE_CAN_BANDWIDTH_AUTO         = 0x40000,
 	FE_CAN_GUARD_INTERVAL_AUTO    = 0x80000,
 	FE_CAN_HIERARCHY_AUTO         = 0x100000,
+	FE_CAN_RECOVER                = 0x20000000,
+	FE_CAN_CLEAN_SETUP            = 0x40000000,
 	FE_CAN_MUTE_TS                = 0x80000000
 } fe_caps_t;
 
@@ -99,25 +101,25 @@
 };                              /*  errorcode when no message was received  */
 
 
-typedef enum {
+typedef enum fe_sec_voltage {
         SEC_VOLTAGE_13,
         SEC_VOLTAGE_18
 } fe_sec_voltage_t;
 
 
-typedef enum {
+typedef enum fe_sec_tone_mode {
         SEC_TONE_ON,
         SEC_TONE_OFF
 } fe_sec_tone_mode_t;
 
 
-typedef enum {
+typedef enum fe_sec_mini_cmd {
         SEC_MINI_A,
         SEC_MINI_B
 } fe_sec_mini_cmd_t;
 
 
-typedef enum {
+typedef enum fe_status {
 	FE_HAS_SIGNAL     = 0x01,   /*  found something above the noise level */
 	FE_HAS_CARRIER    = 0x02,   /*  found a DVB signal  */
 	FE_HAS_VITERBI    = 0x04,   /*  FEC is stable  */
@@ -125,17 +127,17 @@
 	FE_HAS_LOCK       = 0x10,   /*  everything's working... */
 	FE_TIMEDOUT       = 0x20,   /*  no lock within the last ~2 seconds */
 	FE_REINIT         = 0x40    /*  frontend was reinitialized,  */
-} fe_status_t;                      /*  application is recommned to reset */
+} fe_status_t;                      /*  application is recommended to reset */
                                     /*  DiSEqC, tone and parameters */
 
-typedef enum {
+typedef enum fe_spectral_inversion {
         INVERSION_OFF,
         INVERSION_ON,
         INVERSION_AUTO
 } fe_spectral_inversion_t;
 
 
-typedef enum {
+typedef enum fe_code_rate {
         FEC_NONE = 0,
         FEC_1_2,
         FEC_2_3,
@@ -149,7 +151,7 @@
 } fe_code_rate_t;
 
 
-typedef enum {
+typedef enum fe_modulation {
         QPSK,
         QAM_16,
         QAM_32,
@@ -160,13 +162,13 @@
 } fe_modulation_t;
 
 
-typedef enum {
+typedef enum fe_transmit_mode {
 	TRANSMISSION_MODE_2K,
 	TRANSMISSION_MODE_8K,
 	TRANSMISSION_MODE_AUTO
 } fe_transmit_mode_t;
 
-typedef enum {
+typedef enum fe_bandwidth {
 	BANDWIDTH_8_MHZ,
 	BANDWIDTH_7_MHZ,
 	BANDWIDTH_6_MHZ,
@@ -174,7 +176,7 @@
 } fe_bandwidth_t;
 
 
-typedef enum {
+typedef enum fe_guard_interval {
 	GUARD_INTERVAL_1_32,
 	GUARD_INTERVAL_1_16,
 	GUARD_INTERVAL_1_8,
@@ -183,7 +185,7 @@
 } fe_guard_interval_t;
 
 
-typedef enum {
+typedef enum fe_hierarchy {
 	HIERARCHY_NONE,
 	HIERARCHY_1,
 	HIERARCHY_2,
@@ -257,5 +259,5 @@
 #define FE_GET_EVENT               _IOR('o', 78, struct dvb_frontend_event)
 
 
-#endif /*_FRONTEND_H_*/
+#endif /*_DVBFRONTEND_H_*/
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/net.h linux-2.5.67-ac1/include/linux/dvb/net.h
--- linux-2.5.67/include/linux/dvb/net.h	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/net.h	2003-04-07 21:17:58.000000000 +0100
@@ -39,6 +39,7 @@
 
 #define NET_ADD_IF                 _IOWR('o', 52, struct dvb_net_if)
 #define NET_REMOVE_IF              _IO('o', 53)
+#define NET_GET_IF                 _IOWR('o', 54, struct dvb_net_if)
 
 #endif /*_DVBNET_H_*/
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/osd.h linux-2.5.67-ac1/include/linux/dvb/osd.h
--- linux-2.5.67/include/linux/dvb/osd.h	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/osd.h	2003-04-07 21:17:58.000000000 +0100
@@ -25,83 +25,83 @@
 #define _DVBOSD_H_
 
 typedef enum {
-	// All functions return -2 on "not open"
+  // All functions return -2 on "not open"
   OSD_Close=1,    // ()
-	// Disables OSD and releases the buffers
-	// returns 0 on success
-	OSD_Open,		// (x0,y0,x1,y1,BitPerPixel[2/4/8](color&0x0F),mix[0..15](color&0xF0))
-	// Opens OSD with this size and bit depth
-	// returns 0 on success, -1 on DRAM allocation error, -2 on "already open"
-	OSD_Show,		// ()
-	// enables OSD mode
-	// returns 0 on success
-	OSD_Hide,		// ()
-	// disables OSD mode
-	// returns 0 on success
-	OSD_Clear,		// ()
-	// Sets all pixel to color 0
-	// returns 0 on success
-	OSD_Fill,		// (color)
-	// Sets all pixel to color <col>
-	// returns 0 on success
-	OSD_SetColor,		// (color,R{x0},G{y0},B{x1},opacity{y1})
-	// set palette entry <num> to <r,g,b>, <mix> and <trans> apply
-	// R,G,B: 0..255
-	// R=Red, G=Green, B=Blue
-	// opacity=0:      pixel opacity 0% (only video pixel shows)
-	// opacity=1..254: pixel opacity as specified in header
-	// opacity=255:    pixel opacity 100% (only OSD pixel shows)
-	// returns 0 on success, -1 on error
-	OSD_SetPalette,		// (firstcolor{color},lastcolor{x0},data)
-	// Set a number of entries in the palette
-	// sets the entries "firstcolor" through "lastcolor" from the array "data"
-	// data has 4 byte for each color:
-	// R,G,B, and a opacity value: 0->transparent, 1..254->mix, 255->pixel
-	OSD_SetTrans,		// (transparency{color})
-	// Sets transparency of mixed pixel (0..15)
-	// returns 0 on success
-	OSD_SetPixel,		// (x0,y0,color)
-	// sets pixel <x>,<y> to color number <col>
-	// returns 0 on success, -1 on error
-	OSD_GetPixel,		// (x0,y0)
-	// returns color number of pixel <x>,<y>,  or -1
-	OSD_SetRow,		// (x0,y0,x1,data)
-	// fills pixels x0,y through  x1,y with the content of data[]
-	// returns 0 on success, -1 on clipping all pixel (no pixel drawn)
-	OSD_SetBlock,		// (x0,y0,x1,y1,increment{color},data)
-	// fills pixels x0,y0 through  x1,y1 with the content of data[]
-	// inc contains the width of one line in the data block,
-	// inc<=0 uses blockwidth as linewidth
-	// returns 0 on success, -1 on clipping all pixel
-	OSD_FillRow,		// (x0,y0,x1,color)
-	// fills pixels x0,y through  x1,y with the color <col>
-	// returns 0 on success, -1 on clipping all pixel
-	OSD_FillBlock,		// (x0,y0,x1,y1,color)
-	// fills pixels x0,y0 through  x1,y1 with the color <col>
-	// returns 0 on success, -1 on clipping all pixel
-	OSD_Line,		// (x0,y0,x1,y1,color)
-	// draw a line from x0,y0 to x1,y1 with the color <col>
-	// returns 0 on success
-	OSD_Query,		// (x0,y0,x1,y1,xasp{color}}), yasp=11
-	// fills parameters with the picture dimensions and the pixel aspect ratio
-	// returns 0 on success
-	OSD_Test,		// ()
-	// draws a test picture. for debugging purposes only
-	// returns 0 on success
+  // Disables OSD and releases the buffers
+  // returns 0 on success
+  OSD_Open,       // (x0,y0,x1,y1,BitPerPixel[2/4/8](color&0x0F),mix[0..15](color&0xF0))
+  // Opens OSD with this size and bit depth
+  // returns 0 on success, -1 on DRAM allocation error, -2 on "already open"
+  OSD_Show,       // ()
+  // enables OSD mode
+  // returns 0 on success
+  OSD_Hide,       // ()
+  // disables OSD mode
+  // returns 0 on success
+  OSD_Clear,      // ()
+  // Sets all pixel to color 0
+  // returns 0 on success
+  OSD_Fill,       // (color)
+  // Sets all pixel to color <col>
+  // returns 0 on success
+  OSD_SetColor,   // (color,R{x0},G{y0},B{x1},opacity{y1})
+  // set palette entry <num> to <r,g,b>, <mix> and <trans> apply
+  // R,G,B: 0..255
+  // R=Red, G=Green, B=Blue
+  // opacity=0:      pixel opacity 0% (only video pixel shows)
+  // opacity=1..254: pixel opacity as specified in header
+  // opacity=255:    pixel opacity 100% (only OSD pixel shows)
+  // returns 0 on success, -1 on error
+  OSD_SetPalette, // (firstcolor{color},lastcolor{x0},data)
+  // Set a number of entries in the palette
+  // sets the entries "firstcolor" through "lastcolor" from the array "data"
+  // data has 4 byte for each color:
+  // R,G,B, and a opacity value: 0->transparent, 1..254->mix, 255->pixel
+  OSD_SetTrans,   // (transparency{color})
+  // Sets transparency of mixed pixel (0..15)
+  // returns 0 on success
+  OSD_SetPixel,   // (x0,y0,color)
+  // sets pixel <x>,<y> to color number <col>
+  // returns 0 on success, -1 on error
+  OSD_GetPixel,   // (x0,y0)
+  // returns color number of pixel <x>,<y>,  or -1
+  OSD_SetRow,     // (x0,y0,x1,data)
+  // fills pixels x0,y through  x1,y with the content of data[]
+  // returns 0 on success, -1 on clipping all pixel (no pixel drawn)
+  OSD_SetBlock,   // (x0,y0,x1,y1,increment{color},data)
+  // fills pixels x0,y0 through  x1,y1 with the content of data[]
+  // inc contains the width of one line in the data block,
+  // inc<=0 uses blockwidth as linewidth
+  // returns 0 on success, -1 on clipping all pixel
+  OSD_FillRow,    // (x0,y0,x1,color)
+  // fills pixels x0,y through  x1,y with the color <col>
+  // returns 0 on success, -1 on clipping all pixel
+  OSD_FillBlock,  // (x0,y0,x1,y1,color)
+  // fills pixels x0,y0 through  x1,y1 with the color <col>
+  // returns 0 on success, -1 on clipping all pixel
+  OSD_Line,       // (x0,y0,x1,y1,color)
+  // draw a line from x0,y0 to x1,y1 with the color <col>
+  // returns 0 on success
+  OSD_Query,      // (x0,y0,x1,y1,xasp{color}}), yasp=11
+  // fills parameters with the picture dimensions and the pixel aspect ratio
+  // returns 0 on success
+  OSD_Test,       // ()
+  // draws a test picture. for debugging purposes only
+  // returns 0 on success
 // TODO: remove "test" in final version
-	OSD_Text,		// (x0,y0,size,color,text)
-	OSD_SetWindow,		//  (x0) set window with number 0<x0<8 as current
-	OSD_MoveWindow,		//  move current window to (x0, y0)  
+  OSD_Text,       // (x0,y0,size,color,text)
+  OSD_SetWindow, //  (x0) set window with number 0<x0<8 as current
+  OSD_MoveWindow, //  move current window to (x0, y0)  
 } OSD_Command;
 
 typedef struct osd_cmd_s {
-	OSD_Command cmd;
-	int x0;
-	int y0;
-	int x1;
-	int y1;
-	int color;
-	void *data;
+        OSD_Command cmd;
+        int x0;
+        int y0;
+        int x1;
+        int y1;
+        int color;
+        void *data;
 } osd_cmd_t;
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/dvb/video.h linux-2.5.67-ac1/include/linux/dvb/video.h
--- linux-2.5.67/include/linux/dvb/video.h	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/dvb/video.h	2003-04-07 21:17:58.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #else
 #include <stdint.h>
+#include <time.h>
 #endif
 
 
