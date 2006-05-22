Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWEVBLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWEVBLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEVBLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:11:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:43629 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932384AbWEVBLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:11:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ayoeXqd8S/6bs5aIIN+GogKuf7fyzeQGMhOoI/zv53ODWN0jVyVb7Flwe/4lixus6/xxcN4qTIxQx0IjY5UgVSurhGajAqp+dtcqGnzdPJvzEGiGH3jIM5spDeSOYenS+I96KyLCN26rMBtQuwperIpZ0hmn/xNNDPhig4njJoA=
Message-ID: <f02dbbe70605211811h10f5464aw377bf4c5069b25eb@mail.gmail.com>
Date: Mon, 22 May 2006 10:11:43 +0900
From: "Seiji Munetoh" <seiji.munetoh@gmail.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [PATCH 1/2] tpm: bios log parsing fixes
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20060518235423.GA5566@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147994863.14102.65.camel@localhost.localdomain>
	 <20060518235423.GA5566@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/5/19, Alexey Dobriyan <adobriyan@gmail.com>:
> On Fri, May 19, 2006 at 08:27:43AM +0900, Seiji Munetoh wrote:
> > This patch fixes "tcpa_pc_event" misalignment between enum, strings and
> > TCG PC spec and output of the event contains a hash data.
>
> > --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c
> > +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c
> > @@ -105,6 +105,12 @@ static const char* tcpa_event_type_strin
> >       "Non-Host Info"
> >  };
> >
> > +struct tcpa_pc_event {
> > +     u32 event_id;
> > +     u32 event_size;
> > +     u8 event_data[0];
> > +};
> > +
> >  enum tcpa_pc_event_ids {
> >       SMBIOS = 1,
> >       BIS_CERT,
> > @@ -114,14 +120,16 @@ enum tcpa_pc_event_ids {
> >       NVRAM,
> >       OPTION_ROM_EXEC,
> >       OPTION_ROM_CONFIG,
> > +     UNUSED2,
>
> Damn true. Comment, that it corresponds to "" before "Option ROM
> microcode", should not harm.
>
> Why aren't event_id's of proper type asking for removal every time
> someone greps for tcpa_pc_event_ids?

I hope this is the last fix.

>
> >       OPTION_ROM_MICROCODE,
> >       S_CRTM_VERSION,
> >       S_CRTM_CONTENTS,
> >       POST_CONTENTS,
> > +     HOST_TABLE_OF_DEVICES,
> >  };
> >
> >  static const char* tcpa_pc_event_id_strings[] = {
> > -     ""
> > +     "",
> >       "SMBIOS",
> >       "BIS Certificate",
> >       "POST BIOS ",
> > @@ -130,11 +138,12 @@ static const char* tcpa_pc_event_id_stri
> >       "NVRAM",
> >       "Option ROM",
> >       "Option ROM config",
> > -     "Option ROM microcode",
> > +     "",
> > +     "Option ROM microcode ",
> >       "S-CRTM Version",
> > -     "S-CRTM Contents",
> > -     "S-CRTM POST Contents",
> > -     "POST Contents",
> > +     "S-CRTM Contents ",
> > +     "POST Contents ",
>                       ^
> Seems gratious, really needed?

That is specified by the latest spec,  "TCG PC Client Specific Implementation
Specification For Conventional BIOS v1.20". p79, 10.4.2.3.1.2.
https://www.trustedcomputinggroup.org/groups/pc_client/TCG_PCClientImplementationforBIOS_1-20_1-00.pdf

There are some minor changes between v1.1b to v1.2 and this patch
supports v1.2.

Thanks
--
Seiji Munetoh

>
> > +     "Table of Devices",
> >  };
> >
> >  /* returns pointer to start of pos. entry of tcg log */
> > @@ -206,7 +215,7 @@ static int get_event_name(char *dest, st
> >       const char *name = "";
> >       char data[40] = "";
> >       int i, n_len = 0, d_len = 0;
> > -     u32 event_id;
> > +     struct tcpa_pc_event *pc_event;
> >
> >       switch(event->event_type) {
> >       case PREBOOT:
> > @@ -235,31 +244,32 @@ static int get_event_name(char *dest, st
> >               }
> >               break;
> >       case EVENT_TAG:
> > -             event_id = be32_to_cpu(*((u32 *)event_entry));
> > +             pc_event = (struct tcpa_pc_event *)event_entry;
> >
> >               /* ToDo Row data -> Base64 */
> >
> > -             switch (event_id) {
> > +             switch (pc_event->event_id) {
> >               case SMBIOS:
> >               case BIS_CERT:
> >               case CMOS:
> >               case NVRAM:
> >               case OPTION_ROM_EXEC:
> >               case OPTION_ROM_CONFIG:
> > -             case OPTION_ROM_MICROCODE:
> >               case S_CRTM_VERSION:
> > -             case S_CRTM_CONTENTS:
> > -             case POST_CONTENTS:
> > -                     name = tcpa_pc_event_id_strings[event_id];
> > +                     name = tcpa_pc_event_id_strings[pc_event->event_id];
> >                       n_len = strlen(name);
> >                       break;
> > +             /* hash data */
> >               case POST_BIOS_ROM:
> >               case ESCD:
> > -                     name = tcpa_pc_event_id_strings[event_id];
> > +             case OPTION_ROM_MICROCODE:
> > +             case S_CRTM_CONTENTS:
> > +             case POST_CONTENTS:
> > +                     name = tcpa_pc_event_id_strings[pc_event->event_id];
> >                       n_len = strlen(name);
> >                       for (i = 0; i < 20; i++)
> > -                             d_len += sprintf(data, "%02x",
> > -                                             event_entry[8 + i]);
> > +                             d_len += sprintf(&data[2*i], "%02x",
> > +                                             pc_event->event_data[i]);
> >                       break;
> >               default:
> >                       break;
>
>
