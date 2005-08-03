Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVHCKMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVHCKMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVHCKMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:12:37 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:20142 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262189AbVHCKLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:11:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=anS9ZGD3GzLHpERUsYPJtKWe7Z+ob756+6pz7sz/7VDrkuyApXwq2se1w+ZfatxizZKu7sO1/vaBe4QeK5BHBR+tyzhal3g5IYy3ki+uLnm2PMWds52hqR2ikGqhPzNiFeABDNAyjL9lKHcVVNtsWOxeu+CDPgPs8dz3Czcy2pg=
Message-ID: <1c1c86360508030311486fc30a@mail.gmail.com>
Date: Wed, 3 Aug 2005 22:11:07 +1200
From: mdew <some.nzguy@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Fw: ati-remote strangeness from 2.6.12 onwards
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20050803055413.GB1399@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_703_9962099.1123063867176"
References: <20050730173253.693484a2.akpm@osdl.org>
	 <1c1c8636050801220442d8351c@mail.gmail.com>
	 <20050803055413.GB1399@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_703_9962099.1123063867176
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pavel,

Further testing, I initated xmodmap -e "keycode $X =3D p" (where X was
10->255), so theoritcally, all the buttons on the ati-remote should be
mapped to "p". I found the TV Button, The DVD Button, the CH-/+ and
the OK Button all non-working, every other button produced the "p".
xbindkeys -mk doesnt respond to those particular keys either.

these changes occured after 2.6.11, which have caused it not to
respond correctly

-=09{KIND_FILTERED, 0xc8, 0x03, EV_KEY, KEY_PROG1, 1},      /* TV */
-=09{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_PROG2, 1},      /* DVD */
+=09{KIND_FILTERED, 0xc8, 0x03, EV_KEY, KEY_TV, 1},         /* TV */
+=09{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_DVD, 1},        /* DVD */
-=09{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
+=09{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK" */

couldnt get the channelup/down to work correctly, even reversing the
orginal patch doesnt help.

-=09{KIND_FILTERED, 0xd1, 0x0c, EV_KEY, KEY_CHANNELUP, 1},  /* CH + */
-=09{KIND_FILTERED, 0xd0, 0x0b, EV_KEY, KEY_CHANNELDOWN, 1},/* CH - */
+=09{KIND_FILTERED, 0xd0, 0x0b, EV_KEY, KEY_CHANNELUP, 1},  /* CH + */
+=09{KIND_FILTERED, 0xd1, 0x0c, EV_KEY, KEY_CHANNELDOWN, 1},/* CH - */

however this one change is fine.

-=09{KIND_FILTERED, 0xea, 0x25, EV_KEY, KEY_PLAYCD, 1},     /* ( >) */
+=09{KIND_FILTERED, 0xea, 0x25, EV_KEY, KEY_PLAY, 1},       /* ( >) */


My orginal patch was incorrect, heres a revised patch, fixes the OK
button and the TV/DVD button issue. Would be nice to get it included
into 2.6.13 ;-)

On 8/3/05, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>=20
> > I discovered a minor change in 2.6.10-mm1, changing this value back
> > corrects the "ok" button issue.
> >
> >
> > diff -urN linux/drivers/usb/input/ati_remote.c
> > linux-2.6.11/drivers/usb/input/ati_remote.c
> > --- linux/drivers/usb/input/ati_remote.c        2005-08-02
> > 17:56:26.000000000 +1200
> > +++ linux-2.6.11/drivers/usb/input/ati_remote.c 2005-08-02
> > 17:54:34.000000000 +1200
> > @@ -263,7 +263,7 @@
> >         {KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* righ=
t */
> >         {KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down=
 */
> >         {KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up *=
/
> > -       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK"=
 */
> > +       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK"=
 */
> >         {KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL =
+ */
> >         {KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL =
- */
> >         {KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE=
  */
>=20
> I'd say that KEY_ENTER is perhaps more logical there? It is certainly
> more usefull than "OK" key.
>                                                                 Pavel
>=20
> --
> teflon -- maybe it is a trademark, but it should not be.
>

------=_Part_703_9962099.1123063867176
Content-Type: text/x-patch; name="ati-remotefix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ati-remotefix.patch"

ZGlmZiAtcnVOIGxpbnV4LTIuNi4xMi9kcml2ZXJzL3VzYi9pbnB1dC9hdGlfcmVtb3RlLmMgbGlu
dXgtMi42LjEyLW1vZGlmaWVkL2RyaXZlcnMvdXNiL2lucHV0L2F0aV9yZW1vdGUuYwotLS0gbGlu
dXgtMi42LjEyL2RyaXZlcnMvdXNiL2lucHV0L2F0aV9yZW1vdGUuYwkyMDA1LTA2LTE4IDA3OjQ4
OjI5LjAwMDAwMDAwMCArMTIwMAorKysgbGludXgtMi42LjEyLW1vZGlmaWVkL2RyaXZlcnMvdXNi
L2lucHV0L2F0aV9yZW1vdGUuYwkyMDA1LTA4LTAzIDA5OjU0OjQ4LjAwMDAwMDAwMCArMTIwMApA
QCAtMjUyLDggKzI1Miw4IEBACiAJe0tJTkRfRklMVEVSRUQsIDB4ZGQsIDB4MTgsIEVWX0tFWSwg
S0VZX0tQRU5URVIsIDF9LCAgICAvKiAiY2hlY2siICovCiAJe0tJTkRfRklMVEVSRUQsIDB4ZGIs
IDB4MTYsIEVWX0tFWSwgS0VZX01FTlUsIDF9LCAgICAgICAvKiAibWVudSIgKi8KIAl7S0lORF9G
SUxURVJFRCwgMHhjNywgMHgwMiwgRVZfS0VZLCBLRVlfUE9XRVIsIDF9LCAgICAgIC8qIFBvd2Vy
ICovCi0Je0tJTkRfRklMVEVSRUQsIDB4YzgsIDB4MDMsIEVWX0tFWSwgS0VZX1RWLCAxfSwgICAg
ICAgICAvKiBUViAqLwotCXtLSU5EX0ZJTFRFUkVELCAweGM5LCAweDA0LCBFVl9LRVksIEtFWV9E
VkQsIDF9LCAgICAgICAgLyogRFZEICovCisJe0tJTkRfRklMVEVSRUQsIDB4YzgsIDB4MDMsIEVW
X0tFWSwgS0VZX1BST0cxLCAxfSwgICAgICAvKiBUViAqLworCXtLSU5EX0ZJTFRFUkVELCAweGM5
LCAweDA0LCBFVl9LRVksIEtFWV9QUk9HMiwgMX0sICAgICAgLyogRFZEICovCiAJe0tJTkRfRklM
VEVSRUQsIDB4Y2EsIDB4MDUsIEVWX0tFWSwgS0VZX1dXVywgMX0sICAgICAgICAvKiBXRUIgKi8K
IAl7S0lORF9GSUxURVJFRCwgMHhjYiwgMHgwNiwgRVZfS0VZLCBLRVlfQk9PS01BUktTLCAxfSwg
IC8qICJib29rIiAqLwogCXtLSU5EX0ZJTFRFUkVELCAweGNjLCAweDA3LCBFVl9LRVksIEtFWV9F
RElULCAxfSwgICAgICAgLyogImhhbmQiICovCkBAIC0yNjMsNyArMjYzLDcgQEAKIAl7S0lORF9G
SUxURVJFRCwgMHhlNCwgMHgxZiwgRVZfS0VZLCBLRVlfUklHSFQsIDF9LCAgICAgIC8qIHJpZ2h0
ICovCiAJe0tJTkRfRklMVEVSRUQsIDB4ZTcsIDB4MjIsIEVWX0tFWSwgS0VZX0RPV04sIDF9LCAg
ICAgICAvKiBkb3duICovCiAJe0tJTkRfRklMVEVSRUQsIDB4ZGYsIDB4MWEsIEVWX0tFWSwgS0VZ
X1VQLCAxfSwgICAgICAgICAvKiB1cCAqLwotCXtLSU5EX0ZJTFRFUkVELCAweGUzLCAweDFlLCBF
Vl9LRVksIEtFWV9PSywgMX0sICAgICAgICAgLyogIk9LIiAqLworCXtLSU5EX0ZJTFRFUkVELCAw
eGUzLCAweDFlLCBFVl9LRVksIEtFWV9FTlRFUiwgMX0sICAgICAgLyogIk9LIiAqLwogCXtLSU5E
X0ZJTFRFUkVELCAweGNlLCAweDA5LCBFVl9LRVksIEtFWV9WT0xVTUVET1dOLCAxfSwgLyogVk9M
ICsgKi8KIAl7S0lORF9GSUxURVJFRCwgMHhjZCwgMHgwOCwgRVZfS0VZLCBLRVlfVk9MVU1FVVAs
IDF9LCAgIC8qIFZPTCAtICovCiAJe0tJTkRfRklMVEVSRUQsIDB4Y2YsIDB4MGEsIEVWX0tFWSwg
S0VZX01VVEUsIDF9LCAgICAgICAvKiBNVVRFICAqLwo=
------=_Part_703_9962099.1123063867176--
