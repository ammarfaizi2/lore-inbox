Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWAMEMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWAMEMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMEMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:12:10 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:57756 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964799AbWAMEMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:12:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Date: Thu, 12 Jan 2006 23:12:04 -0500
User-Agent: KMail/1.8.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20051225212041.GA6094@hansmi.ch> <1137022900.5138.66.camel@localhost.localdomain> <20060112000830.GB10142@hansmi.ch>
In-Reply-To: <20060112000830.GB10142@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601122312.05210.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 19:08, Michael Hanselmann wrote:
> On Thu, Jan 12, 2006 at 10:41:40AM +1100, Benjamin Herrenschmidt wrote:
> > I don't understand the comment above ? You are adding this to all struct
> > hid_device ? There can be only one of those keyboards plugged at one
> > point in time, I don't think there is any problem having the above
> > static in the driver rather than in the hid_device structure.
> 
> While I don't agree on that, I still modified the patch.
>

I disagree as well, but if we get semantics right we can merge it in
this form and adjust later. 
 
> +static int usbhid_pb_fnmode = 1;
> +module_param_named(pb_fnmode, usbhid_pb_fnmode, int, 0644);
> +MODULE_PARM_DESC(usbhid_pb_fnmode,
> +	"Mode of fn key on PowerBooks (0 = disabled, "
> +	"1 = fkeyslast, 2 = fkeysfirst)");
> +#endif
> +

That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this is
for compatibility with ADB, why do we have 3 options? Doesn't ADB have
only 2?

>  #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
>  #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
>  #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
> @@ -73,6 +135,80 @@ static struct {
>  #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
>  #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
>  
> +static inline struct hidinput_key_translation *find_translation(

I thought is was agreed that we'd avoid "inlines" in .c files?

> +	struct hidinput_key_translation *table, u16 from)
> +{
> +	struct hidinput_key_translation *trans;
> +
> +	/* Look for the translation */
> +	for(trans = table; trans->from && (trans->from != from); trans++);
> +
> +	return (trans->from?trans:NULL);
> +}

I'd prefer liberal amount of spaces applied here </extreme nitpick mode>

> +
> +static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
> +	struct hid_usage *usage, __s32 value)
> +{
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +	struct hidinput_key_translation *trans;
> +
> +	if (usage->code == KEY_FN) {
> +		if (value) hid->quirks |=  HID_QUIRK_POWERBOOK_FN_ON;
> +		else       hid->quirks &= ~HID_QUIRK_POWERBOOK_FN_ON;
> +
> +		input_event(input, usage->type, usage->code, value);
> +
> +		return 1;
> +	}
> +
> +	if (usbhid_pb_fnmode) {
> +		int try_translate, do_translate;
> +
> +		trans = find_translation(powerbook_fn_keys, usage->code);
> +		if (trans) {
> +			if (test_bit(usage->code, usbhid_pb_fn))
> +				do_translate = 1;
> +			else if (trans->flags & POWERBOOK_FLAG_FKEY)
> +				do_translate =
> +					(usbhid_pb_fnmode == 2 &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON)) ||
> +					(usbhid_pb_fnmode == 1 && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_ON));
> +			else
> +				do_translate = (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
> +
> +			if (do_translate) {
> +				if (value)
> +					set_bit(usage->code, usbhid_pb_fn);
> +				else
> +					clear_bit(usage->code, usbhid_pb_fn);
> +
> +				input_event(input, usage->type, trans->to, value);
> +
> +				return 1;
> +			}
> +		}
> +
> +		try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> +				test_bit(LED_NUML, input->led);
> +		if (try_translate) {

Isn't this the same as 

		if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))

but harder to read?

-- 
Dmitry
