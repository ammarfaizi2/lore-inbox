Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264439AbUD2NAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbUD2NAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUD2NAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:00:11 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:28370
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S264439AbUD2M73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:59:29 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios/
From: Michael Brown <mebrown@michaels-house.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20040429055028.GH17014@parcelfarce.linux.theplanet.co.uk>
References: <1083217173.1198.2876.camel@debian>
	 <20040429055028.GH17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1083243496.1202.2902.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Apr 2004 07:58:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 00:50, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, Apr 29, 2004 at 12:39:33AM -0500, Michael Brown wrote:
> > +smbios_read_table_entry_point(char *page, char **start,
> > +				off_t off, int count,
> > +				int *eof, void *data)
> > +{
> > +	unsigned int max_off = sizeof(the_smbios_device.table_eps);
> > +	MOD_INC_USE_COUNT;
> > +
> > +	memcpy(page, &the_smbios_device.table_eps, max_off);
> > +
> > +	MOD_DEC_USE_COUNT;
> > +	return max_off;
> > +}
> 
> *LART*
> 
> Use ->owner instead of (racy) messing with MOD_{INC,DEC}_USE_COUNT.

First, thanks for the feedback Al. I really appreciate it.

I had set ->owner in my module init function. 

  in smbios_init():
+       smbios_dir->owner = THIS_MODULE;
  and a bit further down...
+       table_eps_file->owner = THIS_MODULE;

Documentation/DocBook/procfs_example.c is what I used as my example
along with the "Linux Device Drivers" book. The in-tree docs have
MOD_{INC,DEC}_USE_COUNT, so that is what I did. If these are not
necessary, I will remove them. 

Also note that one of my standard tests that I do before submission is a
"while true; insmod smbios; rmmod smbios; done &"
"while true; hexdump -C /proc/smbios/*; done" 

and let it run for a few hours. This code had all passed that test. 

> 
> > +/* Use the more flexible procfs style. We tell the core that we can handle
> > + * >4k transactions by setting *start. When doing this we also have to handle
> > + * our own *eof and make sure not to overrun the page or count given.
> > + */
> > +static ssize_t
> > +smbios_read_table(char *page, char **start,
> > +		off_t offset, int count,
> > +		int *eof, void *data)
> > +{
> > +	u8 *buf;
> > +	int i = 0;
> > +	int max_off = the_smbios_device.smbios_table_real_length;
> > +	MOD_INC_USE_COUNT;
> > +
> > +	if (offset > max_off)
> > +		return 0;
> > +
> > +	if (count > (max_off - offset))
> > +		count = max_off - offset;
> > +
> > +	buf = ioremap(the_smbios_device.table_eps.table_address, max_off);
> > +	if (buf == NULL)
> > +		return -ENXIO;
> > +
> > +	/* memcpy( buffer, buf+pos, count ); */
> > +	for (i = 0; i < count; ++i) {
> > +		page[i] = readb( buf+offset+i );
> > +	}
> > +
> > +	iounmap(buf);
> > +
> > +	*start = page; /* tells procfs that we handle >1 page */
> > +	MOD_DEC_USE_COUNT;
> > +	return count;
> > +}
> 
> ... and the reason why you need to go through procfs default ->read()
> instead of providing an obvious one of your own would be...?  Note that
> it would be smaller and simpler than your callback above.

You will have to excuse my ignorace here. I used the in tree
Documentation/, google, and fs/proc/proc_misc.c as reference. I assume
you mean something like this:


        table_file = create_proc_read_entry( "table",
                                               0444, smbios_dir,
                                               smbios_read_table,
                                               NULL);
	if(table_file)
		table_file->fops.read = &smbios_read_table;

Correct? 

And then in my smbios_read_table, do a normal read-like method where I
put_user().

Comparing the code above to proc_misc.c, it looks like almost the same
amount of code, but it is probably easier to understand than the above
magic (which, admittedly took a while of googling to figure out), but I
thought that was just normal proc/ style and I was just unfamiliar with
it.

I will make these two changes and resubmit later today.

Thanks,
Michael






