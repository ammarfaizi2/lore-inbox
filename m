Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVBAPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVBAPpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVBAPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:45:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:58310 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262050AbVBAPpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:45:07 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
Message-ID: <16895.41970.832512.893906@tut.ibm.com>
Date: Tue, 1 Feb 2005 09:44:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
In-Reply-To: <Pine.LNX.4.61.0501312247150.30794@scrub.home>
References: <16890.38062.477373.644205@tut.ibm.com>
	<Pine.LNX.4.61.0501312247150.30794@scrub.home>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
 > Hi,
 > 
 > On Fri, 28 Jan 2005, Tom Zanussi wrote:
 > 
 > > +static inline int rchan_create_file(const char *chanpath,
 > > +				    struct dentry **dentry,
 > > +				    struct rchan_buf *data)
 > > +{
 > > +	int err;
 > > +	const char * fname;
 > > +	struct dentry *topdir;
 > > +
 > > +	err = rchan_create_dir(chanpath, &fname, &topdir);
 > > +	if (err && (err != -EEXIST))
 > > +		return err;
 > > +
 > > +	err = relayfs_create_file(fname, topdir, dentry, data, S_IRUSR);
 > > +
 > > +	return err;
 > > +}
 > 
 > What protects topdir from being removed inbetween?
 > Why is necessary to let the user create/remove files/dirs at all?

Good point - file/dir creation/removal should only be done by
relay_open/close.  I'll make sure to fix both of these things.

[...]

 > 
 > For the first version I would suggest to use just local_irq_save/_restore.
 > Getting it right with local_add_return is not trivial and I'm pretty sure 
 > your relay_switch_buffer() gets it wrong, e.g. the caller for whom (offset 
 > < bufsize) must close the subbuffer. Also buffer->data in relay_reserve 
 > may have become invalid (e.g. by an interrupt just before it).
 > 

Yes, there are a couple of bugs here, but I think they're easily fixed
- thanks for spotting them.

For the buffer->data problem, the value of buffer->data at the time
offset is reserved would have to be saved along with it for it to make
sense.

For relay_switch_buffer(), only the offset of the first event that
didn't fit would be less than bufsize so if there was a check for that
i.e. if offset < bufsize, calculate padding, otherwise don't and just
continue, the interrupt would continue through and actually accomplish
the buffer switch, while the interrupted event would calculate the
padding and then exit immediately because of the (offset + length <
bufsize) recheck.  Both would then loop around again to retry and
succeed.  Well, I'm not sure that explanation is clear, but it seems
like it should work with that small change.

Please let me know if you disagree or see any other problems.

 > You can also move all the rchan_buf members which are not written to in 
 > the event path and which are common to all channels back to rchan.

Yes, I was actually planning on doing that, but hadn't gotten to it
yet.


Thanks,

Tom

