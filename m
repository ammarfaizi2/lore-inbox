Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbULOJbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbULOJbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbULOJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:31:51 -0500
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:39132 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S262303AbULOJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:31:16 -0500
Message-ID: <41C00439.5070506@tremplin-utc.net>
Date: Wed, 15 Dec 2004 10:30:33 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Nelson <rufus-kernel@hackish.org>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug support for several PSX controlers
References: <41BCA915.3030407@tremplin-utc.net> <41BCB420.1080307@hackish.org> <41BCBE07.8080509@tremplin-utc.net> <41BE421B.8060106@hackish.org>
In-Reply-To: <41BE421B.8060106@hackish.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Nelson wrote:
> Eric Piel wrote:
:
:
>> Is there anyone in particular to tell about those patches? Or is the 
>> normal way that Vojtech inserts the patches in his tree and Linus 
>> pulls it when he feels it's stable enough?
> 
> 
>  From what I see Vojtech accepts them and then Linus eventually pulls 
> from Vojtech's tree.  Here is my modified patch.  Please test it to 
> double check it works.
Ok, I've tried it completly yesterday evening and I confirm it works 
perfectly. There is a minor correction to do concerning the comment of 
GC_PSX_LENGTH: "bytes" need to be changed to "bits" .

Eric



> 
> ---
> From: Eric Piel <Eric.Piel@tremplin-utc.net>
> 
> Fixes hotplug support for PSX controllers and some mis-sized arrays.
> 
> Signed-off-by: Peter Nelson <rufus-kernel@hackish.org>
> ---
> ===== gamecon.c 1.19 vs edited =====
> --- 1.19/drivers/input/joystick/gamecon.c    2004-12-13 20:04:39 -05:00
> +++ edited/gamecon.c    2004-12-13 20:18:02 -05:00
> @@ -228,6 +228,7 @@
> 
> #define GC_PSX_DELAY    25        /* 25 usec */
> #define GC_PSX_LENGTH    8        /* talk to the controller in bytes */
> +#define GC_PSX_BYTES    6        /* the maximum number of bytes to read 
> off the controller */
> 
> #define GC_PSX_MOUSE    1        /* Mouse */
> #define GC_PSX_NEGCON    2        /* NegCon */
> @@ -241,7 +242,7 @@
> #define GC_PSX_SELECT    0x02        /* Pin 3 */
> 
> #define GC_PSX_ID(x)    ((x) >> 4)    /* High nibble is device type */
> -#define GC_PSX_LEN(x)    ((x) & 0xf)    /* Low nibble is length in 
> words */
> +#define GC_PSX_LEN(x)    (((x) & 0xf) << 1)    /* Low nibble is length 
> in bytes/2 */
> 
> static int gc_psx_delay = GC_PSX_DELAY;
> module_param_named(psx_delay, gc_psx_delay, uint, 0);
> @@ -259,13 +260,13 @@
>  * the psx pad.
>  */
> 
> -static void gc_psx_command(struct gc *gc, int b, unsigned char 
> data[GC_PSX_LENGTH])
> +static void gc_psx_command(struct gc *gc, int b, unsigned char data[5])
> {
>     int i, j, cmd, read;
>     for (i = 0; i < 5; i++)
>         data[i] = 0;
> 
> -    for (i = 0; i < 8; i++, b >>= 1) {
> +    for (i = 0; i < GC_PSX_LENGTH; i++, b >>= 1) {
>         cmd = (b & 1) ? GC_PSX_COMMAND : 0;
>         parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
>         udelay(gc_psx_delay);
> @@ -283,7 +284,7 @@
>  * device identifier code.
>  */
> 
> -static void gc_psx_read_packet(struct gc *gc, unsigned char 
> data[5][GC_PSX_LENGTH], unsigned char id[5])
> +static void gc_psx_read_packet(struct gc *gc, unsigned char 
> data[5][GC_PSX_BYTES], unsigned char id[5])
> {
>     int i, j, max_len = 0;
>     unsigned long flags;
> @@ -302,10 +303,11 @@
> 
>     for (i =0; i < 5; i++)                                /* Find the 
> longest pad */
>         if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR]))
> -           && (GC_PSX_LEN(id[i]) > max_len))
> +           && (GC_PSX_LEN(id[i]) > max_len)
> +           && (GC_PSX_LEN(id[i]) <= GC_PSX_BYTES))
>             max_len = GC_PSX_LEN(id[i]);
> 
> -    for (i = 0; i < max_len * 2; i++) {                        /* Read 
> in all the data */
> +    for (i = 0; i < max_len; i++) {                            /* Read 
> in all the data */
>         gc_psx_command(gc, 0, data2);
>         for (j = 0; j < 5; j++)
>             data[j][i] = data2[j];
> @@ -330,7 +332,7 @@
>     struct gc *gc = (void *) private;
>     struct input_dev *dev = gc->dev;
>     unsigned char data[GC_MAX_LENGTH];
> -    unsigned char data_psx[5][GC_PSX_LENGTH];
> +    unsigned char data_psx[5][GC_PSX_BYTES];
>     int i, j, s;
> 
> /*
> 

