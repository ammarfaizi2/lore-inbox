Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUI2N0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUI2N0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUI2N0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:26:40 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:3978 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268404AbUI2NZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:25:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Date: Wed, 29 Sep 2004 08:24:58 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290229.28652.dtor_core@ameritech.net> <20040929093103.GB3150@ucw.cz>
In-Reply-To: <20040929093103.GB3150@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290824.59004.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 04:31 am, Vojtech Pavlik wrote:
> On Wed, Sep 29, 2004 at 02:29:28AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 29 September 2004 02:15 am, Vojtech Pavlik wrote:
> > > On Wed, Sep 29, 2004 at 01:47:34AM -0500, Dmitry Torokhov wrote:
> > > 
> > > > -int alps_detect(struct psmouse *psmouse)
> > > > +int alps_detect(struct psmouse *psmouse, int set_properties)
> > > >  {
> > > > -	return alps_get_model(psmouse) < 0 ? 0 : 1;
> > > > +	if (alps_get_model(psmouse) < 0)
> > > > +		return 0;
> > > > +
> > > > +	if (set_properties) {
> > > > +		psmouse->vendor = "ALPS";
> > > > +		psmouse->name = "TouchPad";
> > > > +	}
> > > > +	return 1;
> > > >  }
> > > 
> > > I think we should return -1 (or -errno) on failure and 0 on success,
> > > like everybody else does.
> > >
> > 
> > All *detect functions return boolean value - either the device was detected or
> > not. I think it makes most sense. Negative error is convenient when function
> > normally returns some other meaningful value, like length. *detect is a simple
> > yes/no question, it is not really an error at all.
> 
> psmouse_probe() is very similar in its use, as are a lot of other
> functions in the serio framework - and they return 0 on success, and -1
> on failure.
> 
> I see it as "detected/initialized" = success (0) and "not detected / failed
> to initialize" = fail (-1).
> 
> I agree that your view also makes sense, however I'd like to keep the
> driver return values consistent to make it easier to read.
>

I have been battling with myself about whether to keep them consistent
with probe/init or make them as they are today... My issue with
*detect returning -1 on failure is that the caller's code will look
like:

        if (max_proto >= PSMOUSE_IMPS && !intellimouse_detect(psmouse, set_properties))
                return PSMOUSE_IMPS;

or 

        if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
                return PSMOUSE_IMPS;

which does not flow for me when I read the code. With pretty much every
other function caller checks for negative and exits in case of error, it
reads naturally as well. Here with multiple btanches I go "... and
intellimouse is NOT detected... oh, wait, it IS detected..."

Oh, well. I guess I will convert them... unless I managed to presuade you
to keep them as is ;).

-- 
Dmitry
