Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTKRHm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 02:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTKRHm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 02:42:58 -0500
Received: from web13009.mail.yahoo.com ([216.136.172.90]:37788 "HELO
	web13009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262395AbTKRHmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 02:42:52 -0500
Message-ID: <20031118074251.62922.qmail@web13009.mail.yahoo.com>
Date: Mon, 17 Nov 2003 23:42:51 -0800 (PST)
From: Amit Patel <patelamitv@yahoo.com>
Subject: Re: scsi_report_lun_scan bug?
To: Andrew Morton <akpm@osdl.org>, Patrick Mansfield <patmans@us.ibm.com>
Cc: patelamitv@yahoo.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031117230033.59f1ef5c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

In my case, I have 16 luns for which report lun
command byte 3 has value 0x80. While doing the length
calculation 
length = ((data[0] << 24) | (data[1] << 16) |
          (data[2] << 8) | (data[3] << 0));

It calucates length as 0xffffff80 and actual number of
luns is calculated as 536870896. I just write small
program with signed and unsigned char array and it
does evaluate as 0xffffff80 as Andrew mentioned.

Thanks
Amit


#include<stdio.h>
main()
{
        char x[10]={0x00,0x00,0x00,0x80};
        char *p;
        unsigned char *q;

        int len;
        int ulen;

        p=(char *)x;
        q=(unsigned char *) x;
        len=((p[0] << 24) | (p[1] << 16) | (p[2] << 8)
| (p[3] <<0));
        ulen=((q[0] << 24) |(q[1] << 16) | (q[2] << 8)
| (q[3] <<0));
        printf("len= %d len=%x\n",len,len);
        printf("ulen= %d ulen=%x\n",ulen,ulen);
}




 
--- Andrew Morton <akpm@osdl.org> wrote:
> Patrick Mansfield <patmans@us.ibm.com> wrote:
> >
> > On Mon, Nov 17, 2003 at 06:48:33PM -0800, Amit
> Patel wrote:
> > > Hi,
> > > 
> > > I am using 2.6-test9-mm3. I noticed while doing
> > > scsi_report_lun_scan(scsi_scan.c:891) the data
> > > returned is assigned(scsi_scan.c:993) to signed
> char
> > > array which causes the reported number of luns
> to be
> > > huge while calculating num_luns to scan. Is
> there any
> > > particular reason to be data is signed or just a
> bug?
> > > 
> > > I changed it to unsigned char and it seems to
> work
> > > fine. I have attached a diff of scsi_scan.c. Let
> me
> > > know if I am missing something.
> > 
> > I don't see why making it signed or unsigned would
> make any difference.
> 
> 
>  	length = ((data[0] << 24) | (data[1] << 16) |
>  		  (data[2] << 8) | (data[3] << 0));
> 
> If data[3] is 0xff, this expression will always
> evaluate to
> 0xffffffff.  etcetera.
> 
> > It should really be a u8, since it is a pointer to
> an array of bytes.
> > 
> > (And all the scsi_cmd[]'s should be u8.)
> 
> Yup.
> 
> diff -puN
> drivers/scsi/scsi_scan.c~scsi_report_lun-fix
> drivers/scsi/scsi_scan.c
> --- 25/drivers/scsi/scsi_scan.c~scsi_report_lun-fix
> 2003-11-17 20:22:49.000000000 -0800
> +++ 25-akpm/drivers/scsi/scsi_scan.c	2003-11-17
> 20:22:49.000000000 -0800
> @@ -899,7 +899,7 @@ static int
> scsi_report_lun_scan(struct s
>  	unsigned int retries;
>  	struct scsi_lun *lunp, *lun_data;
>  	struct scsi_request *sreq;
> -	char *data;
> +	u8 *data;
>  
>  	/*
>  	 * Only support SCSI-3 and up devices.
> @@ -990,7 +990,7 @@ static int
> scsi_report_lun_scan(struct s
>  	/*
>  	 * Get the length from the first four bytes of
> lun_data.
>  	 */
> -	data = (char *) lun_data->scsi_lun;
> +	data = (u8 *) lun_data->scsi_lun;
>  	length = ((data[0] << 24) | (data[1] << 16) |
>  		  (data[2] << 8) | (data[3] << 0));
>  
> 
> _
> 


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
