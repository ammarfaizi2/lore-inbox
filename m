Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJHQDo>; Tue, 8 Oct 2002 12:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJHQDo>; Tue, 8 Oct 2002 12:03:44 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:58518 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261293AbSJHQDk>;
	Tue, 8 Oct 2002 12:03:40 -0400
Date: Tue, 8 Oct 2002 18:09:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ducrot Bruno <poup@poupinou.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I8042_CMD_AUX_TEST oddities for some mouses.
Message-ID: <20021008180913.A19339@ucw.cz>
References: <20021008144523.GA983@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008144523.GA983@poup.poupinou.org>; from poup@poupinou.org on Tue, Oct 08, 2002 at 04:45:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 04:45:23PM +0200, Ducrot Bruno wrote:

> Some aux ports report false values when we send a I8042_CMD_AUX_TEST,
> which prevent an 'good' probe :(
> 
> The values I am aware are 0x01 and PSMOUSE_RET_ACK (taken from FreeBSD).
> 
> My own accupoint return 0x02.  I suggest then to do something like

Do you have any accupoint docs?

> attached file (but perhaps with a config, or force option)?

I guess the only way is to remove the test altogether, as the values are
defined:

00 : OK
01 : Clock Error
02 : Data Error
03 : Clock + Data Error
fa : Undefined (OK)
ff : Unknown Error (common => OK)

Other values don't happen.

Most controllers return 00. Some ff, some fa. Now if we're going to take
01 and 02 as OK as well, then everything is OK and we don't have to test
at all.

And now I've received a report that some AUX ports don't bother to even
do the LOOP command.

> --- linux-2.5.41/drivers/input/serio/i8042.c	Tue Oct  1 09:06:17 2002
> +++ linux-2.5.40-ac5/drivers/input/serio/i8042.c	Tue Oct  8 15:10:25 2002
> @@ -581,7 +581,7 @@
>   * operation.
>   */
>  
> -	if (i8042_command(&param, I8042_CMD_AUX_TEST) || (param && param != 0xff))
> +	if (i8042_command(&param, I8042_CMD_AUX_TEST) || (param && param != 0x01 && param != 0x02 && param != 0xfa && param != 0xff))
>  		return -1;
>  
>  /*

To keep at least some detection ability (we must not detect AUX on
machines where it isn't present, because they'll hang). I'll apply
this patch:


ChangeSet@1.599, 2002-10-08 17:36:32+02:00, vojtech@suse.cz
  Make i8042.c even less picky about detecting an AUX port because of
  broken chipsets that don't support the LOOP command or report failure
  on the TEST command. Hopefully this won't screw any old 386/486
  systems without the AUX port.


 i8042.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Oct  8 18:08:33 2002
+++ b/drivers/input/serio/i8042.c	Tue Oct  8 18:08:33 2002
@@ -654,24 +654,26 @@
 	i8042_flush();
 
 /*
- * Internal loopback test - filters out AT-type i8042's
+ * Internal loopback test - filters out AT-type i8042's. Unfortunately
+ * SiS screwed up and their 5597 doesn't support the LOOP command even
+ * though it has an AUX port.
  */
 
 	param = 0x5a;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5)
-		return -1;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) {
 
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
  * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
  * 0xfa - no error on some notebooks which ignore the spec
- * We ignore general error, since some chips report it even under normal
- * operation.
+ * Because it's common for chipsets to return error on perfectly functioning
+ * AUX ports, we test for this only when the LOOP command failed.
  */
 
-	if (i8042_command(&param, I8042_CMD_AUX_TEST)
-	    || (param && param != 0xfa && param != 0xff))
-		return -1;
+		if (i8042_command(&param, I8042_CMD_AUX_TEST)
+		    	|| (param && param != 0xfa && param != 0xff))
+				return -1;
+	}
 
 /*
  * Bit assignment test - filters out PS/2 i8042's in AT mode



-- 
Vojtech Pavlik
SuSE Labs
