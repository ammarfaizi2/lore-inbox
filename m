Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSFFPUk>; Thu, 6 Jun 2002 11:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSFFPUj>; Thu, 6 Jun 2002 11:20:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9999 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316989AbSFFPUh>; Thu, 6 Jun 2002 11:20:37 -0400
Date: Thu, 6 Jun 2002 11:29:12 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre10-ac2
Message-ID: <20020606142912.GK1068@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020605151741.GD6438@conectiva.com.br> <Pine.LNX.4.44.0206060808360.26634-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 06, 2002 at 08:09:05AM +0200, Zwane Mwaikambo escreveu:
> On Wed, 5 Jun 2002, Arnaldo Carvalho de Melo wrote:
> 
> > Em Wed, Jun 05, 2002 at 02:04:48PM -0400, Alan Cox escreveu:
> > > The speakup code would benefit from a chunk of kernel janitoring I think.
> > 
> > me downloading... I have to have something to do on the taxy on my way to the
> > office... 8)
> 
> Thats either a damn long drive, or one helluva fast laptop ;)

or the statement was a joke 8) Anyway, here is the first cleanup, the laptop
is not that fast...

Alan is it important to keep all the ugly #ifdefs for 2.2 compatibility?

- Arnaldo

--- linux-2.4.19-pre10-ac2/drivers/char/speakup/speakup.c	2002-06-05 21:20:11.000000000 -0300
+++ linux-2.4.19-pre10-ac2.acme/drivers/char/speakup/speakup.c	2002-06-06 07:49:39.000000000 -0300
@@ -126,14 +126,14 @@ extern struct spk_synth synth_txprt;
 
 static int errno;
 char *spk_cfg[] = { DEFAULT_SPKUP_VARS };
-long spk_cfg_map = 0;		/* which ones have been re'alloc'ed */
-int synth_file_inuse = 0;
+long spk_cfg_map;		/* which ones have been re'alloc'ed */
+int synth_file_inuse;
 static struct spk_variable spk_vars[] = { SPKUP_VARS };
-static unsigned char pitch_shift = 0;
+static unsigned char pitch_shift;
 char saved_punc_level = 0x30;
-char mark_cut_flag = 0;
-unsigned short mark_x = 0;
-unsigned short mark_y = 0;
+char mark_cut_flag;
+unsigned short mark_x;
+unsigned short mark_y;
 static char synth_name[10] = CONFIG_SPEAKUP_DEFAULT;
 static struct spk_synth *synths[] = {
 #ifdef CONFIG_SPEAKUP_ACNTPC
@@ -276,9 +276,9 @@ char *default_chars[256] = {
 	"white space"
 };
 
-int spk_keydown = 0;
-int bell_pos = 0;
-static int spk_lastkey = 0;
+int spk_keydown;
+int bell_pos;
+static int spk_lastkey;
 
 struct spk_t *speakup_console[MAX_NR_CONSOLES];
 
@@ -466,7 +466,7 @@ int
 speakup_diacr (unsigned char ch, unsigned int currcons)
 {
 	static unsigned char *buf = "\0\0\0\0\0";
-	static int num = 0;
+	static int num;
 	int tmp = 0;
 
 	buf[num++] = ch;
@@ -1147,7 +1147,7 @@ spk_skip (unsigned short cnt)
 int
 spkup_write (const char *buf, int count)
 {
-	static unsigned short rep_count = 0;
+	static unsigned short rep_count;
 	static char old_ch, oldest_ch, count_buf[30], punc_buf[128];
 	int in_count = count;
 	char *punc_search = NULL;
@@ -1306,30 +1306,14 @@ speakup_file_release (struct inode *ip, 
 	return 0;
 }
 
-#if LINUX_VERSION_CODE >= 0x20300
 static struct file_operations synth_fops = {
-	read:speakup_file_read,
-	write:speakup_file_write,
-	ioctl:speakup_file_ioctl,
-	open:speakup_file_open,
-	release:speakup_file_release,
+	.owner	 = THIS_MODULE;
+	.read	 = speakup_file_read,
+	.write	 = speakup_file_write,
+	.ioctl	 = speakup_file_ioctl,
+	.open	 = speakup_file_open,
+	.release = speakup_file_release,
 };
-#else
-static struct file_operations synth_fops = {
-	NULL,			/* seek */
-	speakup_file_read,
-	speakup_file_write,
-	NULL,			/* readdir */
-	NULL,			/* poll */
-	speakup_file_ioctl,
-	NULL,			/* mmap */
-	speakup_file_open,
-	NULL,			/* flush */
-	speakup_file_release,
-	NULL,
-	NULL,			/* fasync */
-};
-#endif
 
 void
 speakup_register_devsynth (void)
@@ -1433,9 +1417,9 @@ speakup_characters_read_proc (char *page
 	return ((count < begin + len - off) ? count : begin + len - off);
 }
 
-static volatile int chars_timer_active = 0;	// indicates when a timer is set
+static volatile int chars_timer_active;	// indicates when a timer is set
 #if (LINUX_VERSION_CODE < 0x20300)	/* is it a 2.2.x kernel? */
-static struct wait_queue *chars_sleeping_list = NULL;
+static struct wait_queue *chars_sleeping_list;
 #else				/* nope it's 2.3.x */
 static DECLARE_WAIT_QUEUE_HEAD (chars_sleeping_list);
 #endif
@@ -1514,9 +1498,9 @@ speakup_characters_write_proc (struct fi
 			       unsigned long count, void *data)
 {
 	static const int max_description_len = 72;
-	static int cnt = 0, num = 0, state = 0;
+	static int cnt, num, state;
 	static char desc[max_description_len + 1];
-	static unsigned long jiff_last = 0;
+	static unsigned long jiff_last;
 	int i;
 	char ch, *s1, *s2;
 
