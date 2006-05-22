Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWEVA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWEVA04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEVA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:26:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:48208 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751547AbWEVA0z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:26:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YIDCWZjavrpP7Ya6I4PKyq7HJFFrVhkun/13cK+v7mIf+KWhZsBZ12Q5/EZYPStelKM5GiTMVK4KYjItjvFlBvLERWwG7VZEh9kBsb/hcsxq+xpK7DY9I4NTKTpxl8Oxw/5+/d34C+iJX8E0+1D4b/eaECTn3orTtx+V6C7kPHo=
Message-ID: <f02dbbe70605211726j51880184jfd01954fc202af9f@mail.gmail.com>
Date: Mon, 22 May 2006 09:26:54 +0900
From: "Seiji Munetoh" <seiji.munetoh@gmail.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] tpm: bios log parsing fixes
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20060518235744.GB5566@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147994947.14102.68.camel@localhost.localdomain>
	 <20060518235744.GB5566@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/5/19, Alexey Dobriyan <adobriyan@gmail.com>:
> On Fri, May 19, 2006 at 08:29:07AM +0900, Seiji Munetoh wrote:
> > This patch fixes the BINARY output format to actual ACPI TCPA log
> > structure for any userland tool easily parse the binary data with
> > reference to TCG PC specification.
> Do you realize that you break backward compatibility? What was wrong
> with old format?

Yes I do, The problem is  the binary output use get_event_name() to convert the
eventdata to ascii format. and the get_event_name() does not support all
eventdata types.Thus userspace application could not get the eventdata which
required to verify the PCRs in TPM.

I think actual ACPI log data is good for the binary output rather than current
unique binary format. It seems we are doing unnecessary transformation.

>
> > --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c
> > +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c
> > @@ -275,53 +285,13 @@ static int get_event_name(char *dest, st
> >
> >  static int tpm_binary_bios_measurements_show(struct seq_file *m, void
> > *v)
> >  {
> > -
> > -     char *eventname;
> > -     char data[4];
> > -     u32 help;
> > -     int i, len;
> >       struct tcpa_event *event = (struct tcpa_event *) v;
> > -     unsigned char *event_entry =
> > -         (unsigned char *) (v + sizeof(struct tcpa_event));
> > -
> > -     eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
> > -     if (!eventname) {
> > -             printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> > -                    __func__);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     /* 1st: PCR used is in little-endian format (4 bytes) */
> > -     help = le32_to_cpu(event->pcr_index);
> > -     memcpy(data, &help, 4);
> > -     for (i = 0; i < 4; i++)
> > -             seq_putc(m, data[i]);
> > -

> > -     /* 2nd: SHA1 (20 bytes) */
> > -     for (i = 0; i < 20; i++)
> > -             seq_putc(m, event->pcr_value[i]);
> > +     char *data = (char *) v;
> > +     int i;
> >
> > -     /* 3rd: event type identifier (4 bytes) */
> > -     help = le32_to_cpu(event->event_type);
> > -     memcpy(data, &help, 4);
> > -     for (i = 0; i < 4; i++)
> > +     for (i = 0;i < sizeof(struct tcpa_event) + event->event_size; i++)
> >               seq_putc(m, data[i]);
> >
> > -     len = 0;
> > -
> > -     len += get_event_name(eventname, event, event_entry);
> > -
> > -     /* 4th:  filename <= 255 + \'0' delimiter */
> > -     if (len > TCG_EVENT_NAME_LEN_MAX)
> > -             len = TCG_EVENT_NAME_LEN_MAX;
> > -
> > -     for (i = 0; i < len; i++)
> > -             seq_putc(m, eventname[i]);
> > -
> > -     /* 5th: delimiter */
> > -     seq_putc(m, '\0');
> > -
> > -     kfree(eventname);
> >       return 0;
> >  }
>
>
