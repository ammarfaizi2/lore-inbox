Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWJYUPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWJYUPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWJYUPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:15:14 -0400
Received: from dxa00.wellsfargo.com ([151.151.65.115]:49368 "EHLO
	dxa00.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1161187AbWJYUPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:15:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Touchscreen hardware hacking/driver hacking.
Date: Wed, 25 Oct 2006 15:08:55 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Touchscreen hardware hacking/driver hacking.
Thread-Index: AcbyMQAlmUmwm8/pSJei8KH7eSW2JgGMp1mg
From: <Greg.Chandler@wellsfargo.com>
To: <dtor@insightbb.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-input@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 25 Oct 2006 20:08:56.0064 (UTC) FILETIME=[66760000:01C6F871]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been thinking about the code I added:
        {
                .ident = "FLORA-ie 55mi",
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "FLORA-ie 55mi"),
                },
        },

That's nice and all that it works, but I'd like to make it work for all
models.  Some don't return the same strings, but do have the same
hardware.  I noticed the same thing with your lifebook models.
I can't find the definition for "DMI_MATCH", of if I did, I sure don't
understand it.  What I'd like to do is something along the lines of:

const char* UPCASEME(string str)
  {
    for (int x = 0; x < str.size(); x = x + 1)
      {
        str[x] = toupper(str[x]);
      }
    return str.c_str();
  }

{
  if (strncmp(UPCASEME(DMI_PRODUCT_NAME), UPCASEME("FLORA-ie ") ,9) ==
0)
    {
      .ident = "FLORA-ie 55mi",
      .matches = { DMI_MATCH(UPCASEME(DMI_PRODUCT_NAME),
UPCASEME("FLORA-ie ")) },
    }
  else if (strncmp(UPCASEME(DMI_PRODUCT_NAME), UPCASEME("LifeBook B")
,10) == 0)
    {
      .ident = "LifeBook B",
      .matches = { DMI_MATCH(UPCASEME(DMI_PRODUCT_NAME),
UPCASEME("LifeBook B")) },
    }
  else
    {
    }
}
 

Now that I have looked at it {going over my code to see if it should
work I saw this in drivers/firmware/dmi_scan.c:
/**
 *      dmi_check_system - check system DMI data
 *      @list: array of dmi_system_id structures to match against
 *              All non-null elements of the list must match
 *              their slot's (field index's) data (i.e., each
 *              list string must be a substring of the specified
 *              DMI slot's string data) to be considered a
 *              successful match.
 *
 *      Walk the blacklist table running matching functions until
someone
 *      returns non zero or we hit the end. Callback function is called
for
 *      each successful match. Returns the number of matches.
 */
int dmi_check_system(struct dmi_system_id *list)

If this is true, maybe that function should be changed to make it
case-insensitive?
If so then, 4 of the pre-existing cases can be summed up as "LifeBook
B", and all of the Flora-ie tablets can be listed as a single entry as
well.

I know somone will object to this as a dangerous assumption that all
models, or all spellings are the same.  Byt the time the flames hit, I
should have my asbestos armour out and ready.  However, I know for a
fact that all of the Hitachi tablets do have this, and for what I have
read so do the lifebooks.  My opinion is that "it's only a PS/2" driver,
what could go wrong.  I'm no kernel developer, and not much of a
developer in general so, now that I've erected the lightning rod I guess
it's time for discussion?

What do you guys think?













-----Original Message-----
From: dmitry.torokhov@gmail.com [mailto:dmitry.torokhov@gmail.com] On
Behalf Of Dmitry Torokhov
Sent: Tuesday, October 17, 2006 4:12 PM
To: Chandler, Greg
Cc: linux-kernel@vger.kernel.org; linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: Touchscreen hardware hacking/driver hacking.

On 10/17/06, Greg.Chandler@wellsfargo.com <Greg.Chandler@wellsfargo.com>
wrote:
>
> I'm working on a prototype Hitachi tablet, it uses a Fujitsu 4-wire 
> resistive touchscreen. {10.4" I think} I've found that windows-xp 
> embedded uses a generic ps/2 driver for the device.
>
> I've ripped this thing to pieces on several occasions looking for 
> chips to help the porting, my problem is that I can not find the 
> analog-digital converter for this thing.  The connector goes to a 
> surface mount header on an 8 layer board.
> I loose the traces almost instantly.  Given that I can't find the 
> converter anywhere what should I do next?
>
> I've done my homework and found that this HAS to be either serial or 
> usb attached according to Fujitsu.
> Aparently it's neither.  There are no unknown USB devices {or known 
> matching}, and there is no activity on the single serial port on the 
> system.  Since the windows driver uses PS/2 as the interface I have a 
> horrible feeling this thing has an interpretation layer that makes it 
> a
> PS/2 mouse, and that may or may not royally be a nightmare.
>

The touchscreen might need a "magic knock" to activate. You might try to
see what data wondows driver sends to PS/2 port.

Also check of Lifebook touchscreen protocol will work for you. You will
need to adjust DMI table in drivers/input/mouse/lifebook.c/

> I would have posted this to a different group but there is no "input"
> mailing list.
>

linux-input@atrey.karlin.mff.cuni.cz

But you must be subscribed to post otherwise list just drops your mails
on the floor.

--
Dmitry


