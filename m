Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbTFLHBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFLHBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:01:36 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:60668 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264783AbTFLHA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:00:57 -0400
Subject: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS w83781d
	during rmmod (2.5.70-bk1[1234]))
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
In-Reply-To: <20030610054107.GA22719@earth.solarsys.private>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
Content-Type: text/plain
Organization: 
Message-Id: <1055401021.5280.3143.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 12 Jun 2003 08:57:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > 
> > Anyhow, Only change I have made to the w83781d driver, is one line
> > (just tell it to that if the chip id is 0x72, its also of type
> > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > it did not with 2.5.68 kernels when I still had the other board.  I will
> > attach a oops tomorrow or such when I get home.
> 
> I reproduced the segfault here.  It looks like i2c_del_driver() tries
> to call w83781d_detach_client() more than once now, partly because of
> the safe list fix in 2.5.70-bk11.  But that function should only be
> called for the "primary" client, not the subclients.
> 
> The quick/ugly patch below fixes the symptom, but maybe not the disease.
> There might be more fundamental brokenness in the whole subclient scheme.
> I'll keep looking when I get the chance.
> 
> --- linux-2.5.70-bk14/drivers/i2c/chips/w83781d.c	2003-06-10 00:49:19.831210956 -0400
> +++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-10 00:53:35.041027614 -0400
> @@ -1412,6 +1412,10 @@
>  	struct w83781d_data *data = i2c_get_clientdata(client);
>  	int err;
>  
> +	/* if this is a subclient, do nothing */
> +	if (!data)
> +		return 0;
> +
>  	/* release ISA region or I2C subclients first */
>  	if (i2c_is_isa_client(client)) {
>  		release_region(client->addr, W83781D_EXTENT);
> 

Nope, this do not fix it.

The problem is actually at the i2c driver side.  From
drivers/i2c/i2c-core.c in i2c_del_driver(), we have:

-----------------------------------
                } else { /* not if (driver->detach_adapter) */
                        list_for_each_safe(item2, _n, &adap->clients) {
                                client = list_entry(item2, struct
i2c_client, list);
                                if (client->driver != driver)
                                        continue;
                                DEB2(printk(KERN_DEBUG "i2c-core.o: "
                                            "detaching client %s:\n",
                                            client->dev.name));
                                if ((res =
driver->detach_client(client))) {
                                        dev_err(&adap->dev, "while "
                                                "unregistering driver "
                                                "`%s', the client at "
                                                "address %02x of "
                                                "adapter could not "
                                                "be detached; driver "
                                                "not unloaded!",
                                                driver->name,
                                                client->addr);
                                        goto out_unlock;
                                }
                        }
                }
-----------------------------------

As list_for_each_safe walk the list, _n gets pointed to a
list that will be removed when detach_client() is called,
and on the next loop, item2 will be set to _n, which is by
now invalid, causing the list_entry() call to put a bogus
pointer in 'client', and ultimately ending up in a oops
when 'if (client->driver != driver)' gets executed.

A working fix is as follows:

-----------------------------------
--- 1/drivers/i2c/i2c-core.c	2003-06-12 00:03:36.000000000 +0200
+++ 2/drivers/i2c/i2c-core.c	2003-06-12 00:06:39.000000000 +0200
@@ -263,6 +263,12 @@ int i2c_del_driver(struct i2c_driver *dr
 						client->addr);
 					goto out_unlock;
 				}
+				/* detach_client() is going to delete the list (&adap->clients)
+				 * from under us, so make sure it is still there before calling
+				 * list_entry again ...
+				 */
+				if (list_empty(&adap->clients))
+					break;
 			}
 		}
 	}
-----------------------------------

This however brings me to a maybe bigger issue ...

1)  Does i2c_del_driver use list_for_each_safe properly

2)  And if it does, is list_for_each_safe as 'safe' as it
    should be ?

The following piece of code demonstrates what happens here
(yes, its not a work of art):

-----------------------------------
#include <stdlib.h>
#include <stdio.h>

struct list;

struct list {
	struct list *prev;
	struct list *next;
};

int main(void)
{
	struct list a, b, c, d;
	struct list *head = &a, *pos, *n;

	a.prev = &d;
	a.next = &b;
	b.prev = &a;
	b.next = &c;
	c.prev = &b;
	c.next = &d;
	d.prev = &c;
	d.next = &a;

	printf("a = 0x%X, b = 0x%X, c = 0x%X, d = 0x%X\n", &a, &b, &c, &d);

	printf("\nRun once, no member removing\n\n");
	/* this for is basically what list_for_each_safe() does ... */
	for (pos = (head)->next, n = pos->next; pos != (head); \
	     pos = n, n = pos->next) {

		printf("  pos = 0x%X\n", pos);
	}

	printf("\n\nRun again, but remove 'c' when pos points to 'b',\n");
	printf("and n points to 'c'\n\n");
        for (pos = (head)->next, n = pos->next; pos != (head); \
             pos = n, n = pos->next) {
                printf("  new pos = 0x%X\n", pos);

		if (c.prev != (struct list *)0x02020202) {
			printf("  * Removing 'c'\n");
			c.prev = (struct list *)0x02020202;
			c.next = (struct list *)0x01010101;
			b.next = &d;
			d.prev = &b;
		}
        }
	
	return 0;
}
-----------------------------------

This give the following result:

-----------------------------------
# ./foo 
a = 0xBFFFF664, b = 0xBFFFF65C, c = 0xBFFFF654, d = 0xBFFFF64C

Run once, no member removing

  pos = 0xBFFFF65C
  pos = 0xBFFFF654
  pos = 0xBFFFF64C


Run again, but remove 'c' when pos points to 'b',
and n points to 'c'

  new pos = 0xBFFFF65C
  * Removing 'c'
  new pos = 0xBFFFF654
Segmentation fault
#
-----------------------------------

Basically, as list_for_each_safe go over the list, it
sets 'n' to the next item, and 'pos' to the previous
value of 'n'.  If list item contained in 'n' is now
however deleted in this instance of the loop, with
the next loop 'pos' will be set to an invalid list
item ... in this case it causes an oops.

If list_for_each_safe *is* used correctly in this
case, then I am afraid that we could see more of
this type of problems.  In only the i2c core drivers,
list_for_each_safe is used once more in the same
fasion.  In the whole tree, it is used more than
200 times ....

Anyhow, comments, etc appreciated.


Regards,

-- 
Martin Schlemmer


