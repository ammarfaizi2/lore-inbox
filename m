Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264306AbUD0W6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbUD0W6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUD0W6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:58:37 -0400
Received: from chococat.sd.dreamhost.com ([66.33.206.16]:23986 "EHLO
	chococat.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S264306AbUD0W6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:58:34 -0400
Message-ID: <4609.171.64.70.113.1083106713.spork@webmail.coverity.com>
In-Reply-To: <20040427221446.GA2662@one-eyed-alien.net>
References: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
    <20040427221446.GA2662@one-eyed-alien.net>
Date: Tue, 27 Apr 2004 15:58:33 -0700 (PDT)
Subject: Re: [CHECKER] Implementation inconsistencies in 2.6.3
From: "Ken Ashcraft" <ken@coverity.com>
To: "Matthew Dharm" <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Reply-To: ken@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Apr 27, 2004 at 02:47:22PM -0700, Ken Ashcraft wrote:
>> I'm trying to cross check implementations of the same interface for
>> errors.  I assume that if functions are assigned to the same function
>> pointer, they are implementations of a common interface and should be
>> consistent with each other.  For example, if one implementation checks
>> one
>> of its arguments for NULL, the other implementation should also check
>> that
>> argument for NULL.
>>
>> In this case, I'm looking at which arguments are referenced at all in
>> the
>> implementation.  If we have 10 implementations and 9 of them read
>> argument
>> 1 and the 10th fails to read argument 1, the 10th implementation may be
>> missing some code.  In each of the reports below, I give an example
>> implementation that does read the argument.  That is followed by an
>> implementation that fails to read the argument.
>>
>
>> ---------------------------------------------------------
>> [BUG] (mdharm-usb@one-eyed-alien.net) looks like it should return count
>> instead of strlen(buf), but this is in scsiglue.c, so is it special
>> code?
>>
>> example:
>> /home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:274:store_rescan_field:
>> NOTE:READ: Checking arg count [EXAMPLE=device_attribute.store-2]
>>
>> /home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:321:store_max_sectors:
>> ERROR:READ: Not checking arg [COUNTER=device_attribute.store-2]  [fit=1]
>> [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=233] [counter=1] [z >
>> 3.20943839741638] [fn-z = -4.35889894354067]
>>
>> 	return sprintf(buf, "%u\n", sdev->request_queue->max_sectors);
>> }
>>
>> /* Input routine for the sysfs max_sectors file */
>>
>> Error --->
>> static ssize_t store_max_sectors(struct device *dev, const char *buf,
>> 		size_t count)
>> {
>> 	struct scsi_device *sdev = to_scsi_device(dev);
>
> My understanding was that I was supposed to return the number of bytes in
> the buffer that I actually used.  I thought 'count' was the maximum size I
> could use.
>

That sounds feasible.  I can't find any documentation on the interface, so
I can't tell.  However, there are ~233 functions that at least reference
count.  Many of them are almost identical: they call sscanf or strtol to
get a length out of buf, pass that length to some subroutine, and then
unconditionally return count.  This is a more representative example than
the one listed above.

static ssize_t set_pwm_enable1(struct device *dev, const char *buf,
                                size_t count)
{
        struct i2c_client *client = to_i2c_client(dev);
        struct asb100_data *data = i2c_get_clientdata(client);
        unsigned long val = simple_strtoul(buf, NULL, 10);
        data->pwm &= 0x0f; /* keep the duty cycle bits */
        data->pwm |= (val ? 0x80 : 0x00);
        asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
        return count;
}


