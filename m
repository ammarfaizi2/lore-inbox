Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbTCNJz1>; Fri, 14 Mar 2003 04:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbTCNJz1>; Fri, 14 Mar 2003 04:55:27 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:59145 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262036AbTCNJzX>; Fri, 14 Mar 2003 04:55:23 -0500
Message-Id: <200303140957.h2E9vfu08416@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, zubarev@us.ibm.com, gregkh@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Date: Fri, 14 Mar 2003 11:54:40 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030313204556.GA3475@linuxhacker.ru>
In-Reply-To: <20030313204556.GA3475@linuxhacker.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2003 22:45, Oleg Drokin wrote:
> Hello!
>
>    There seem to be memleak convert_2digits_to_char() function that
> is triggered during normal operations.
>    Also I think there are some memleaks on error exit paths
>    ebda_rsrc_controller()
>    All of this is addressed by below patch.
>    2.5 seems to have totally different version of this code (and no
>    convert_2digits_to_char() function at all for example).
>    Found with help of smatch + enhanced unfree script.
>
> Bye,
>     Oleg

Oleg, you are doing great job. Thanks!

Well.. I just looked into that function. Do we have a kernel
obfuscated C contest? ;)

> ===== drivers/hotplug/ibmphp_ebda.c 1.6 vs edited =====
> --- 1.6/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 21:56:25 2002
> +++ edited/drivers/hotplug/ibmphp_ebda.c	Thu Mar 13 23:40:29 2003
> @@ -597,8 +597,8 @@
>  	char *str1;
>
>  	str = (char *) kmalloc (3, GFP_KERNEL);

BTW, that char* str is not local. It is not even static.
It is global symbol: "char *chassis_str, *rxe_str, *str;"

> -	memset (str, 0, 3);
> -	str1 = (char *) kmalloc (2, GFP_KERNEL);

A bit weird to have 3 and 2 bytes allocated in two separate kmalloc()

> +	if (!str)
> +		return NULL;
>  	memset (str, 0, 3);

This was fun, right? "Lets add second memset just in case
first failed" ;) ;)

>  	bit = (int)(var / 10);
>  	switch (bit) {
> @@ -608,13 +608,20 @@
>  		return str;
>  	default:
>  		//2 digits number
> +		str1 = (char *) kmalloc (2, GFP_KERNEL);
> +		if (!str1) {
> +			break;
> +		}
> +		memset (str, 0, 3);
> +             memset (str, 0, 3);
>               *str1 = (char)(bit + 48);
>               strncpy (str, str1, 1);
>               memset (str1, 0, 3);

Wow! *str1 is 2 bytes long, not 3!

Anyway, here is the diff against some old 2.5 (sorry don't have latest
tree here at the moment). Also here are old and new functions
for easy visual diff. Completely untested:

static char *convert_2digits_to_char (int var)
{
        int bit;
        char *str1;

        str = (char *) kmalloc (3, GFP_KERNEL);
        memset (str, 0, 3);
        str1 = (char *) kmalloc (2, GFP_KERNEL);
        memset (str, 0, 3);
        bit = (int)(var / 10);
        switch (bit) {
        case 0:
                //one digit number
                *str = (char)(var + 48);
                return str;
        default:
                //2 digits number
                *str1 = (char)(bit + 48);
                strncpy (str, str1, 1);
                memset (str1, 0, 3);
                *str1 = (char)((var % 10) + 48);
                strcat (str, str1);
                return str;
        }
        return NULL;
}

static char *convert_2digits_to_char (int var)
{
        int bit;

        char *str = (char *) kmalloc (3, GFP_KERNEL);
        if (!str)
                return NULL;
        bit = (int)(var / 10);
        switch (bit) {
        case 0:
                //one digit number
                str[0] = (char)(var + '0');
                str[1] = 0;
                break;
        default:
                //2 digits number
                str[0] = (char)(bit + '0');
                str[1] = (char)((var % 10) + '0');
                str[2] = 0;
                break;
        }
        return str;
}
--
vda

--- ibmphp_ebda.c	Mon Nov 11 05:28:05 2002
+++ ibmphp_ebda.new.c	Fri Mar 14 11:46:28 2003
@@ -65,7 +65,7 @@
 static LIST_HEAD (opt_lo_head);
 static void *io_mem;
 
-char *chassis_str, *rxe_str, *str;
+char *chassis_str, *rxe_str;
 
 /* Local functions */
 static int ebda_rsrc_controller (void);
@@ -594,28 +594,25 @@
 static char *convert_2digits_to_char (int var)
 {
 	int bit;	
-	char *str1;
 
-	str = (char *) kmalloc (3, GFP_KERNEL);
-	memset (str, 0, 3);
-	str1 = (char *) kmalloc (2, GFP_KERNEL);
-	memset (str, 0, 3);
+	char *str = (char *) kmalloc (3, GFP_KERNEL);
+	if (!str)
+		return NULL;	
 	bit = (int)(var / 10);
 	switch (bit) {
 	case 0:
 		//one digit number
-		*str = (char)(var + 48);
-		return str;
+		str[0] = (char)(var + '0');
+		str[1] = 0;
+		break;
 	default: 	
 		//2 digits number
-		*str1 = (char)(bit + 48);
-		strncpy (str, str1, 1);
-		memset (str1, 0, 3);
-		*str1 = (char)((var % 10) + 48);
-		strcat (str, str1);
-		return str;
-	}	
-	return NULL;	
+		str[0] = (char)(bit + '0');
+		str[1] = (char)((var % 10) + '0');
+		str[2] = 0;
+		break;
+	}
+	return str;
 }
 
 /* Since we don't know the max slot number per each chassis, hence go
