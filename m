Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVBPFUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVBPFUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVBPFUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:20:33 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:56921 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261987AbVBPFUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:20:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: PATCH 2.6.11-rc4]: IBM TrackPoint configuration support
Date: Wed, 16 Feb 2005 00:20:21 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c2050213163253b9b98f@mail.gmail.com> <20050215141618.GC8119@ucw.cz> <a71293c205021520134f75ea3c@mail.gmail.com>
In-Reply-To: <a71293c205021520134f75ea3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502160020.21638.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, couple of more things (and I promise I will shut up ;))

>  /*
> + * Try to initialize the IBM TrackPoint
> + */
> +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> +		psmouse->vendor = "IBM";
> +		psmouse->name = "TrackPoint";
> + 
> +		return PSMOUSE_PS2;
> +	}

I would like you to change the code so that psmouse structure only
changed when set_properties is set. Probably moving these into 
trackpoint_init is a good idea since _init should not override 
psmouse->private unless told to do so. It is important when the device
was not identified as a trackpoint but later (let's say after resume)
it is - in this case generic reconnect will cause psmouse_extensions
with set_properties = 0 to verify protocol and we dont' want to change
anything in psmouse to give the original disconnect handler change to
clean up properly.

Thinking about it some more I am pretty sure that you need a special
protocol number for the trackpoint, because protocol number is used
by psmouse_reconnect to check whether reconnect can be done or rescan
is needed. You can reuse the standard protocol handler, but you need
the new number. This way if trackpad was not identified as such first
time around, but is identified on reconnect psmouse-base would notice
that it is a new type of device and schedule reconnect and will proper
cleanup/initialization.

Does this make sense?

> +
> +#define MAKE_ATTR_WRITE(_item, command) \
> +        static ssize_t psmouse_attr_set_##_item(struct psmouse
> *psmouse, const char *buf, size_t count) \

It looks like the patch got mangled on it's way, please check your mail
client.

> +        { \
> +		char *rest; \
> +                unsigned long value; \
> +                struct trackpoint_data *tp = psmouse->private; \
> +                value = simple_strtoul(buf, &rest, 10); \

Whitespace damage (tabs vs. spaces). Also there are some trailing
whitespace. If you are using vi I find the following helpful to 
highlight the problem spots:

set listchars=tab:\|-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

-- 
Dmitry
