Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265062AbUD3Eiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUD3Eiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUD3Eiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 00:38:54 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:54738
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S265062AbUD3Eiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 00:38:51 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
From: Michael Brown <mebrown@michaels-house.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20040430033408.GR17014@parcelfarce.linux.theplanet.co.uk>
References: <1083291712.1203.2914.camel@debian>
	 <20040430033408.GR17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1083299856.1195.2924.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Apr 2004 23:37:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good stuff! Thanks for the feedback Al. Give me a few minutes and I will
send an updated patch.

Comments/Questions below.

On Thu, 2004-04-29 at 22:34, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, Apr 29, 2004 at 09:21:52PM -0500, Michael Brown wrote:
> > +	u32 fp = 0xF0000;
> > +	while (fp < 0xFFFFF) {
> > +		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> > +		if (memcmp(table_eps->anchor, "_SM_", 4)==0 &&
> > +					checksum_eps(table_eps)) {
> > +			return 0;
> > +		}
> > +		fp += 16;
> > +	}
> 
> Stilistic note:
> 	for (fp = 0xf0000; fp < 0xfffff; fp += 16) {
> 		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> 		if (memcmp(table_eps->anchor, "_SM_", 4) != 0)
> 			continue;
> 		if (checksum_eps(table_eps))
> 			return 0;
> 	}

Will change. I like your version.

Originally copied from Alan Cox's stuff, so if Alan's style is off, oh
well... :-)

> 
> > +	while(keep_going && ((ptr - buf) <= max_length) && count < max_count){
> > +		if (ptr[0] == 0x7F)   /* ptr[0] is type */
> > +			keep_going = 0;
> > +
> > +		ptr += ptr[1]; /* ptr[1] is length, skip structure */
> > +		/* skip strings at end of structure */
> > +		while((ptr-buf) < max_length && (ptr[0] || ptr[1]))
> > +			++ptr;
> 
> It looks like an off-by-one - if ptr reaches buf + max_length - 1, ptr[1]
> appears to be beyond the area it's OK to dereference.

Great spot. Updating, changed "<= max_length" to "<= (max_length-1)".

> 
> > +                size_t count, loff_t *ppos)
> > +{
> > +	unsigned long origppos = *ppos;
> > +	unsigned long max_off = the_smbios_device.smbios_table_real_length;
> > +	u8 *ptr;
> > +
> > +	if(*ppos >= max_off)
> > +		return 0;
> 
> Note that *ppos is signed here.  llseek() to negative and you've got a problem.

Added "|| *ppos < 0" to the check.

> 
> > +	while (*ppos < max_off) {
> > +		put_user(readb(ptr + *ppos), buf);
> > +		++(*ppos); ++buf;
> > +	}
> 
> Eeek...
> 
> 	a) that's called copy_to_user()
> 	b) you'd better check the return value (either of put_user() or
> copy_to_user()).

Ok, will update, but I have one question. for (A), is this equivalent to
copy_to_user() even with the readb() in there? Sorry if this is a stupid
question.

If I get a bad return from either of these, is "return -EINVAL"
appropriate?
--
Michael






