Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWFAJaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFAJaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWFAJaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:30:19 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:12008 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S932183AbWFAJaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:30:17 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.5.230):SA:0(-102.3/1.7):. Processed in 4.65506 secs Process 9338)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Page Allocation Failure, Why?? Bug in kernel??
Date: Thu, 1 Jun 2006 15:07:09 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMGEHNCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000A_01C6858D.0DC27AD0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C6858D.0DC27AD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I tried to run an application, try-sound.c. In the course of the run of the
application I repeatedly got page allocation failure, despite the fact that
enough pages are free. Why this is so, is it a bug in mm subsystem of Linux
kernel 2.6.13?

The Page allocation failure is as follows:

insmod: page allocation failure. order:5, mode:0xd0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:5
cpu 0 cold: low 0, high 2, batch 1 used:1
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         944kB (0kB HighMem)
Active:1611 inactive:279 dirty:0 writeback:0 unstable:0 free:236 slab:483
mapped:1378 pagetables:43
DMA free:944kB min:512kB low:640kB high:768kB active:6444kB inactive:1116kB
present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 106*4kB 11*8kB 5*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
944kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
450 free pages
593 reserved pages
483 slab pages
291 pages shared
0 pages swap cached

Before this failure the /proc/buddyinfo is as follows:

Node 0, zone      DMA     43      5      5      3      2      2      0
0      0

After the failure the /proc/buddyinfo is as follows:

Node 0, zone      DMA     77     13      5      3      2      2      0
0      0

Any pointer to help understand this behavior will be highly appreciated.

~Abu.

------=_NextPart_000_000A_01C6858D.0DC27AD0
Content-Type: application/octet-stream;
	name="try-sound.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="try-sound.c"

#include <stdio.h>=0A=
#include <malloc.h>=0A=
#include <fcntl.h>=0A=
=0A=
// YoKu 20-10-04 for PMU=0A=
#include <linux/i2c.h>=0A=
#include <linux/i2c-dev.h>=0A=
// YoKu=0A=
=0A=
=0A=
#define PAGES 900=0A=
#define SIGPAGE 4096 =0A=
#define REFERESH 0=0A=
// LCD                          VDIG_1=0A=
#define LCD                     2    =0A=
=0A=
// LCD_BACKLIGHT                CURR1=0A=
#define LCD_BACKLIGHT           3       =0A=
#define I2C_DEV 		"/dev/i2c-0"	// I2C Device File=0A=
#define PMU_CHARGER		"/dev/PMU_CHARGER"=0A=
#define WAVE_PIPE		"/tmp/WAVE_PIPE"=0A=
#define PMU_ADDR                0x41            // PMU Write Address=0A=
#define POWER_CONTROL           9=0A=
#define ON           1=0A=
#define OFF          0=0A=
#define LCD_ON_MASK                     0x04            // 0000 0100    =
POWER_CONTROL=0A=
#define LCD_BACKLIGHT_ON_MASK           0x04            // 0000 0100    =
CURR_CONTROL=0A=
#define CURR_CONTROL            40=0A=
#define CURR_MODE		41=0A=
=0A=
=0A=
int fdI2C;=0A=
unsigned char gbyLCDBackOn =3D 1;=0A=
=0A=
fn_SwitchDev(unsigned char byDev, unsigned char byOp)=0A=
{=0A=
	__s16  byPresent_val;=0A=
=0A=
	 if ( byDev =3D=3D LCD )=0A=
        {=0A=
                if( (byPresent_val =3D i2c_smbus_read_byte_data(fdI2C , =
POWER_CONTROL)) < 0) =0A=
		{=0A=
		       perror("\nfn_SwitchDev: I2C POWER_CONTROL Read Fail") ;=0A=
		}=0A=
                else=0A=
                {=0A=
                        if ( byOp =3D=3D ON )=0A=
			{=0A=
                                byPresent_val |=3D LCD_ON_MASK;=0A=
#ifdef MAIN_DEBUG=0A=
				printf("\nPMU: Switching LCD ON");=0A=
#endif=0A=
			}=0A=
                        else=0A=
			{=0A=
                                byPresent_val &=3D ~LCD_ON_MASK;=0A=
#ifdef MAIN_DEBUG=0A=
				printf("\nPMU: Switching LCD OFF");=0A=
#endif=0A=
			}=0A=
                        if(i2c_smbus_write_byte_data( fdI2C, =
POWER_CONTROL, byPresent_val ) < 0) =0A=
			{=0A=
			         perror("\nfn_SwitchDev: I2C POWER_CONTROL write Fail") ;=0A=
			}=0A=
                }=0A=
        }=0A=
	else if ( byDev =3D=3D LCD_BACKLIGHT )=0A=
	{=0A=
		if( (byPresent_val =3D i2c_smbus_read_byte_data( fdI2C , CURR_CONTROL =
)) < 0)=0A=
		{=0A=
			perror("\nfn_SwitchDev: I2C CURR_CONTROL Read Fail") ;=0A=
		}=0A=
		else=0A=
		{=0A=
			//pthread_mutex_lock(&_mutgbyLCDBackOn);=0A=
			if ( byOp =3D=3D ON )=0A=
			{=0A=
				byPresent_val |=3D LCD_BACKLIGHT_ON_MASK;=0A=
#ifdef MAIN_DEBUG=0A=
				printf("\nPMU: Switching LCD BACKLIGHT ON");=0A=
#endif=0A=
				if(i2c_smbus_write_byte_data( fdI2C, CURR_CONTROL, byPresent_val ) < =
0)=0A=
                                	perror("\nfn_SwitchDev: I2C =
CURR_CONTROL write Fail") ;=0A=
				else=0A=
					gbyLCDBackOn =3D 1;=0A=
			}=0A=
			else=0A=
			{=0A=
				byPresent_val &=3D ~LCD_BACKLIGHT_ON_MASK;=0A=
#ifdef MAIN_DEBUG=0A=
				printf("\nPMU: Switching LCD BACKLIGHT OFF");=0A=
#endif=0A=
				if(i2c_smbus_write_byte_data( fdI2C, CURR_CONTROL, byPresent_val ) < =
0)=0A=
                                	perror("\nfn_SwitchDev: I2C =
CURR_CONTROL write Fail") ;=0A=
				else=0A=
					gbyLCDBackOn =3D 0;=0A=
			}=0A=
			//pthread_mutex_unlock(&_mutgbyLCDBackOn);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
int main()=0A=
{=0A=
	int i=3D-1;=0A=
	static unsigned int cntr =3D 0 ;=0A=
	char *poarray,*p2=3DNULL;=0A=
=0A=
	system("cat /proc/meminfo");=0A=
	for (i=3D0;i<PAGES;i++)=0A=
	{=0A=
		poarray=3D(char*)malloc(SIGPAGE);=0A=
		memset(poarray, '\0', SIGPAGE);	=0A=
		if(poarray=3D=3DNULL)=0A=
		{=0A=
			printf("\nError in allocating\n");=0A=
			exit(1);=0A=
		}=0A=
	}=0A=
=0A=
	if( (fdI2C =3D open(I2C_DEV,O_RDWR)) < 0 )                // Open I2C =
Device=0A=
        {=0A=
                perror("\nMAIN: Cannot open I2C device\n") ;=0A=
        }=0A=
	else=0A=
	{=0A=
		// Write 'PMU Write addr' to I2C Device=0A=
	        if (ioctl(fdI2C,I2C_SLAVE,PMU_ADDR) < 0)=0A=
        	{=0A=
                	perror("\nMAIN: I2C PMU_ADDR Write Fail");=0A=
        	}=0A=
       		 printf("\nMAIN: I2C PMU_ADDR Write Success.fdI2c =3D %d" =
,fdI2C );=0A=
	}=0A=
=0A=
	fn_SwitchDev(LCD, 1);=0A=
	fn_SwitchDev(LCD_BACKLIGHT, 1);=0A=
=0A=
=0A=
	while(1)=0A=
	{=0A=
		cntr ++ ;=0A=
		fn_SwitchDev(LCD_BACKLIGHT, 0);=0A=
		printf("\nREMOVING MODULES Ittr=3D%d \n" , cntr);=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/meminfo");=0A=
		system("cat /proc/buddyinfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-pcm-oss");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/meminfo");=0A=
		system("cat /proc/buddyinfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-mixer-oss");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-pxa2xx-ac97");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-pxa2xx-pcm");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-ac97-codec");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-pcm");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-page-alloc");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd-timer");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod snd");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("rmmod soundcore");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
=0A=
		sleep(2);=0A=
		fn_SwitchDev(LCD_BACKLIGHT, 1);=0A=
        	p2=3D(char*)malloc(100);=0A=
        	if(p2 =3D=3D NULL)=0A=
        	{=0A=
        		printf("OOM PROBLEM");=0A=
	        }   =0A=
 =0A=
		system("lsmod");=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
=0A=
//		system("echo 150 >/proc/sys/pm/suspend");=0A=
=0A=
		system("cat /proc/meminfo");=0A=
=0A=
		printf("\nInserting Modules\n");=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/soundcore.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-timer.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-page-alloc.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-pcm.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-ac97-codec.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-pxa2xx-pcm.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-pxa2xx-ac97.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-mixer-oss.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
		sleep(REFERESH);=0A=
		system("/sbin/insmod /lib/modules/2.6.13/alsa/snd-pcm-oss.ko");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("rmmod linuxdrv");=0A=
		sleep(REFERESH);=0A=
		system("cat /proc/buddyinfo");=0A=
		system("cat /proc/meminfo");=0A=
=0A=
		system("/sbin/insmod /root/linuxdrv.ko");=0A=
		system("cat /proc/meminfo");=0A=
		system("lsmod");=0A=
		system("cat /proc/buddyinfo");=0A=
		sleep(REFERESH);=0A=
		free(p2);=0A=
		p2 =3D NULL;=0A=
	}=0A=
}=0A=

------=_NextPart_000_000A_01C6858D.0DC27AD0--

