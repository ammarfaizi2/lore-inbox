Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTDIWRm (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTDIWRm (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:17:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13707 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263870AbTDIWRk convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499275003618@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499274993464@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:40 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1133.1.4, 2003/04/08 12:31:53-07:00, azarah@gentoo.org

[PATCH] i2c: remove compiler warning in w83781d sensor driver

On Wed, 2003-04-09 at 00:04, Greg KH wrote:

> Oh, I'm getting the following warning when building the driver, want to
> look into this?
>
> drivers/i2c/chips/w83781d.c: In function `store_fan_div_reg':
> drivers/i2c/chips/w83781d.c:715: warning: `old3' might be used uninitialized in this function
>

It is because old3 is only referenced if:

 ((data->type != w83781d) && data->type != as99127f)

as those two chips don't have extended divisor bits ...

It is however set in the first occurrence:

       /* w83781d and as99127f don't have extended divisor bits */
       if ((data->type != w83781d) && data->type != as99127f) {
               old3 = w83781d_read_value(client, W83781D_REG_VBAT);
       }

and thus is rather gcc being brain dead for not being able to figure
old3 is only used within a if block like that.

I was not sure about style policy in a case like this, so I left it as
is, it should however be possible to 'fix' it with:


 drivers/i2c/chips/w83781d.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:15:55 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:15:55 2003
@@ -712,7 +712,7 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 val, old, old2, old3;
+	u32 val, old, old2, old3 = 0;
 
 	val = simple_strtoul(buf, NULL, 10);
 	old = w83781d_read_value(client, W83781D_REG_VID_FANDIV);

