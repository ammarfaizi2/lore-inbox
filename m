Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbSLMBgr>; Thu, 12 Dec 2002 20:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLMBgr>; Thu, 12 Dec 2002 20:36:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35739 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267588AbSLMBfI>; Thu, 12 Dec 2002 20:35:08 -0500
Message-ID: <3DF93A71.15678A95@us.ibm.com>
Date: Thu, 12 Dec 2002 17:40:01 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Werner Almesberger <werner@almesberger.net>,
       James Keniston <kenistoj@us.ibm.com>
Subject: Proposal:  Alan Cox dev_printk() with advanced logging support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract:

The goals of this proposal are to: 
(1) provide a consistent method for identifying which device printk() messages 
    are referring to; and, 
(2) when you need advanced logging capabilities, a way to enable them without
    having to modify any device driver that's already using existing macros
    dev_err(), dev_info(), dev_warn(), or dev_dbg(), and without altering the
    contents of /var/log/messages at all.

(some editorial liberties were taken when combining Alan's comments from 
several notes...)

In September, Alan Cox wrote in response to my last logging proposal...

> We have a problem about consistently reporting which device. So
> dev_printk(dev, ...) is printk that formats up the device info for you.
[SNIP]
> Why not just start with
>
>        dev_printk(dev, KERN_ERR "Exploded mysteriously");
>
> and a few notification type things people can add eg
>
>        dev_failed(dev);
>        dev_offline(dev);
>
> much like we keep network status. 
[SNIP]
> Its also easy to use and happens to pass a device pointer into the
> places you want it for more detailed logging
[SNIP]
> We don't (modify printk behavior). We add an extra helper that builds 
> on it in a totally logical fashion. The existing one doesnt break, its
> merely something to be polished when needed by the folks who care
[SNIP]
> ...you end up with a set
> of patches you add over time. I would note however that the default
> dev_printk() routine that just reformats up as
>
>   <level>%s: message
>
> ...That gives you the infrastructure to know what is going on. 

Currently dev_printk() is not in the kernel, but the following
logging macros were added in 2.5 (in include/linux/device.h)...

  #ifdef DEBUG
  #define dev_dbg(dev, format, arg...)            \
         printk (KERN_DEBUG "%s %s: " format ,   \
                 (dev).driver->name , (dev).bus_id , ## arg)
  #else
  #define dev_dbg(dev, format, arg...) do {} while (0)
  #endif

  #define dev_err(dev, format, arg...)            \
         printk (KERN_ERR "%s %s: " format ,     \
                 (dev).driver->name , (dev).bus_id , ## arg)
  #define dev_info(dev, format, arg...)           \
         printk (KERN_INFO "%s %s: " format ,    \
                 (dev).driver->name , (dev).bus_id , ## arg)
  #define dev_warn(dev, format, arg...)           \
         printk (KERN_WARNING "%s %s: " format , \
                 (dev).driver->name , (dev).bus_id , ## arg)

The version of dev_printk() being proposed here is essentially a
generalized version of these macros, with a small change to Alan's 
version so that driver name and bus_id are prepended to the 
message...

  #define dev_printk(sev, dev, format, arg...) \
      printk(sev "%s %s: " format, (dev).driver->name, (dev).bus_id, ##arg)
 
Then the logging macros in device.h can be re-written like this...
   #define dev_err(dev, format, arg...)           \
         dev_printk(KERN_ERR, (dev), format, ## arg)
..and so on.  
 
Since network devices don't currently use the device model, a similar 
macro, possibly called netdev_printk(), which takes struct net_device as the 
dev argument, will be needed as well. 

But for now, here's the second part of the dev_printk() proposal...


Advanced Logging
----------------

(Note:  For folks who have commented on previous LKML postings about
 logging, and don't see your issues addressed here, _please_ see the
 "_not_ addressed" list at the very bottom ;-)

As Alan pointed-out...
    
> (dev_printk)...happens to pass a device pointer into the
> places you want it for more detailed logging 

So what features are desirable for advanced, detailed logging ?
Here are the features that I (and other like-minded folks) think
are important ...

Inside dev_printk(), and completely transparent to device drivers
that would be using dev_printk(), when CONFIG_EVLOG=yes...

(1) As "more detailed" implies, additional event data from the device struct
    is logged than is written to printk.  The initial proposed event data...
      driver->name  (also written to printk)
      bus_id        (also written to printk)
      addr 
      name  
      power_state
          
    Additionally, event data is "tagged" with attribute names to provide
    a more precise way of singling-out events in the log.  For the members of 
    the device struct, assigned names would be dev_driver_name, dev_bus_id,
    dev_addr, etc.

    As the device struct continues to evolve, it will become more clear which
    device attributes are appropriate to log.

(2) Instead of vsnprintf-ing the format string like printk(), the format
    string and args are kept separately in the event record, which provides
    numerous ways of formatting and displaying kernel events in user-space,
    including translation into different languages.  This will be referred
    to later as a PRINTF-format event record.

    Optional formatting templates, which would be automatically generated 
    during kernel build, offer several choices:

    <1> if templates are not applied, default printf-style formatting is
        displayed.

    <2> if the default auto-generated template is used, user-space utils can
        select event records using attribute names like dev_name,
        dev_power_state, etc; and, using command-line options, manipulate very 
        precisely how event data is displayed (very detailed, or very compact, 
        and in what order, etc.).

    <3> The default templates can be copied and modified, and based on 
        environment variable settings, the modified templates will be applied to 
        the event data, instead of the default auto-gen'd templates. 

(3) A unique, automatically generated "reference code" for every call to 
    dev_printk() provides a precise and accurate way to associate formatting
    templates with event records from dev_printk(), drive automated processing
    and analysis of events, etc.

(4) EXACTLY the same message is written to printk()'s ring buffer as if EVLOG 
    was not configured. 

Here's how dev_printk() would look with event logging added...

 #ifdef CONFIG_EVLOG
  #define dev_printk(sev, dev, format, arg...) \
 	printkat(sev "{dev_driver}%s {dev_bus_id}%s: " format \
	"{{dev_addr}%p{dev_name}%s{dev_power}%d{dev_state}%d}", \
	(dev).driver->name, (dev).bus_id, ##arg, \
	&(dev), (dev).name, (dev).power_state, (dev)->saved_state)
 #else
  /* Log via printk only, adding just the driver name and bus ID. */
  #define dev_printk(sev, dev, format, arg...) \
        printk(sev "%s %s: " format, (dev).driver->name, (dev).bus_id, ##arg)
 #endif /* !CONFIG_EVLOG */

Curly braces in the arglist to printkat() are used in the following ways...

{dev_driver} - in this case "dev_driver" will become the attribute name
               utilized by event logging.  "{dev_driver}" will NOT appear
               in the printk message, nor will any other attribute name
               enclosed in curly braces.

{{           - any attributes appearing AFTER this will not appear in the
               printk message (not even the values) and will not display with
               evlog commands unless explicitly specified.  These are
               referred to as "hidden attributes". 

Werner Almesberger suggested some additional creative ways of using curly
braces, but these can be proposed and added over time depending upon 
reponses and comments on the "simple" usage described above.

The printkat() macro inside dev_printk() looks like this...

  #ifndef EVL_FACILITY_NAME
  #ifdef KBUILD_MODNAME
  #define EVL_FACILITY_NAME KBUILD_MODNAME
  #else
  #define EVL_FACILITY_NAME kern
  #endif
  #endif

  /* returns CRC32 of s1, s2 and s3... */
  extern int evl_gen_event_type(const char *s1, const char *s2, const char *s3);

  /*
   * Bloat doesn't matter: this doesn't end up in vmlinux.
   * function and file are required for computation of CRC32, which is
   * part of the "reference code" uniquely identifying a call to dev_printk()
   */
  struct log_position {
     int line;
     char function[64 - sizeof(int)];
     char file[128];
  };
 
  #define _LOG_POS { __LINE__, __FUNCTION__, __FILE__ }
 
  /*
   * Information about a printkat() message.
   * Again, bloat doesn't matter: this doesn't end up in vmlinux.
   * Note that, because of default alignment in the .log section,
   * sizeof(struct log_info) should be a multiple of 32.
   */
  struct log_info {
     char format[128+64];
     char facility[64];
     struct log_position pos;
  };
 
  #define printkat(fmt, ...) \
  ({ \
     static struct log_info __attribute__((section(".log"),unused)) ___ \
        = { fmt, __stringify(EVL_FACILITY_NAME), _LOG_POS }; \
     __printkat(__stringify(EVL_FACILITY_NAME), \
        evl_gen_event_type(__FILE__, __FUNCTION__, fmt), \
        fmt, ##__VA_ARGS__); \
  })
 
The printkat macro is based on macros contributed by Rusty Russell
and stores static details into the .log section in the .o file that can 
then be extracted by a user-space utility to create formatting templates. 
Note that the combination of CRC32 from EVL_FACILITY_NAME and CRC32 
returned from evl_gen_event_type() provides you with an 8-byte reference 
code, as previously mentioned above. 

The __printkat() function, called from the printkat() macro, looks like 
this...

  /*
   * fmt and subsequent args are as with printk.  Log the message to printk
   * (via vprintk), and (if EVLOG is configured) also to evlog as a
   * PRINTF-format record.  Strip {id}s from the message, and also
   * anything following "{{".
   */
  /*ARGSUSED*/
  int __printkat(const char *facname, int evtype, const char *fmt, ...)
  {
         int status;
         unsigned long flags;
         va_list args;
  
         va_start(args, fmt);
  #ifdef CONFIG_EVLOG
         spin_lock_irqsave(&printkat_lock, flags);
         status = evl_printkat(facname, evtype, printkat_buf, fmt, args);
         (void) vprintk(printkat_buf, args);
         spin_unlock_irqrestore(&printkat_lock, flags);
  #else
         /* EVLOG disabled.  Just call printk, stripping {id}s as needed. */
         if (strstr(fmt, "}%") || strstr(fmt, "{{")) {
              spin_lock_irqsave(&printkat_lock, flags);
  /*   
              evl_unbrace(printkat_buf, fmt, POSIX_LOG_ENTRY_MAXLEN);
              status = vprintk(printkat_buf, args);
              spin_unlock_irqrestore(&printkat_lock, flags);
         } else {
                 status = vprintk(fmt, args);
         }
  #endif
         va_end(args);
         return status;
  }

evl_printkat(), called from __printkat()...
     (1) creates a PRINTF-format event record, as previously mentioned,
         where the format string and attributes (including hidden ones) 
         are stored separately in the event record.
     (2) calls vprintk() to store the "normal" printk message into the
         printk ring buffer _without_ attribute names enclosed in curly 
         braces and _without_ hidden attributes after "{{".

evl_unbrace(), also called from __printkat(), strips-out attribute names
in curly braces, and strips-off hidden attributes after "{{".

I am not showing evl_printk() or evl_unbrace() details, or any other event logging 
code because discussions about event record content, structure, buffering of event
records, event buffer size, etc. etc. will be discussed and the issues hammered out 
later.  Although, everything described here has been implemented and tested.

To illustrate, assume this dummy sample code...
  .
  .
  dev_printk(KERN_ALERT, dummy.dev,
           "Device %s is bad!  %d things are in danger!\n",
            dummy.name, dummy.things);
  .
  .
  
The printk message written to /var/log/messages might be...

  Nov 14 13:40:14 localhost kernel: dummy_driver 01:02.3: Device dummy is bad!  5 things are in danger!

The default event display from the "evlview" command might be...

  recid=11, size=158, format=PRINTF, event_type=0xb2958e8c, facility=dev_dummy, 
  severity=ALERT, uid=root, gid=root, pid=3193, pgrp=3193, 
  time=Thu 14 Nov 2002 01:40:14 PM PST, flags=0x2 (KERNEL), thread=0x0, 
  processor=0, host=localhost
  drivers/misc/dev_dummy.c:dev_dummy_init_module:72
  dummy_driver 01:02.3: Device dummy is bad!  5 things are in danger!

The event display from "evlview -m" is identical to printk...
  
  Nov 14 13:40:14 localhost kernel: dummy_driver 01:02.3: Device dummy is bad! 5 things are in danger!

The default formatting template, which is generated by a userspace utility that 
extracts the information from the .log section in the dev_dummy.o file would 
look like this...

  facility "dev_dummy"
  event_type 0xb2958e8c
    /* Raw format = "<1>{dev_driver}%s {dev_bus_id}%s: Device %s is bad!  %d things are in                        danger!\n{{dev_addr}%p{dev_name}%s{dev_power}%d{dev_state}%d}" */
  const {
        string file = "drivers/misc/dev_dummy.c";
        string function = "dev_dummy_init_module";
        int line = 72;
  }
  attributes {
        string fmt;
        int __argsz;
        string dev_driver "%s";
        string dev_bus_id "%s";
        string s3 "%s";
        int d1 "%d";
        address dev_addr "%p";
        string dev_name "%s";
        int dev_power "%d";
        unsigned char dev_saved_state "%d";
  }
  format
  %file%:%function%:%line%
  %fmt:printk%
  END

By copying the template and modifying just the "format" section of the template
to expose "hidden attributes"...

   format string
   "%file%:%function%:%line%"
   "\n%fmt:printk%"
   "\n-----------------------------------"
   "\ndriver = %dev_driver%"
   "\nbus_id = %dev_bus_id%"
   "\naddr   = %dev_addr%"
   "\nname   = %dev_name%"
   "\npower  = %dev_power%"
   "\nsaved_state  = %dev_saved_state%"
   "\n-----------------------------------"
   END

...and setting environment variables to use the modified template, the event 
display from "evlview" now looks like this...

   recid=11, size=158, format=PRINTF, event_type=0xb2958e8c, facility=dev_dummy, 
   severity=ALERT, uid=root, gid=root, pid=3193, pgrp=3193, 
   time=Thu 14 Nov 2002 01:40:14 PM PST, flags=0x2 (KERNEL), thread=0x0, 
   processor=0, host=localhost
   drivers/misc/dev_dummy.c:dev_dummy_init_module:72
   dummy_driver 01:02.3: Device dummy is bad!  5 things are in danger!
   -----------------------------------
   driver = dummy_driver
   bus_id = 01:02.3
   addr   = 0xd0873f80
   name   = Dummy Corp. dummy device model X57
   power  = 0
   saved_state  = 2
   ----------------------------------

BTW, evlview also has options to query on attribute names, even hidden 
ones, and offers an option to display event attributes similar to what
is displayed above (by providing a modified template).

In summary, what this proposal for dev_printk() provides is...

(1) a consistent method for identifying which device printk() messages are 
    referring to.

(2) when you need advanced logging capabilities, a way to enable them without
    having to modify any device driver that's already using dev_printk(), or
    dev_err(), dev_info(), dev_warn(), or dev_dbg(), and without altering the
    content of /var/log/messages at all.

What is _not_ addressed by this proposal are a number of other issues raised
in the past, that still need addressing.  For example...

1) (from Jeff Garzik) There's little or no stanardization of messages across
   different (but similar) devices.

2) (from Jeff Garzik and Greg KH) There's little or no guidance about what device
   specific details are most useful for Problem Determination, Sys Administration,
   etc.

   However, consistently identifying which device, plus state info from the device
   struct, plus other info. like source file, function name, and line number,
   provided with event logging, should certainly be useful in some cases. 
   As the device struct continues to evolve, it will become more clear which
   device attributes are appropriate to log.

3) (from Greg KH) But what happens when the attributes, and events change on every 
   kernel release ?   Who generates new templates, and who will update translations, 
   or even do them in the first place ? 

   Clearly, a user-space utility is required for merging customized templates with
   newer kernel versions.  The Distros, or anyone else 
   interested in post-processing of events in customized ways, will demand these
   utilities.  We could probably write them rather quickly (in a week or less).

4) (from Andrey Savochkin) One of the most important things is handling of log
   messages split over multiple printks, and possibly, multiple lines.  The 
   user-level log management system should be notified that such a dump is just
   a single long piece of information, spread over multiple lines.

   Certainly, variations on dev_printk() can be developed (like netdev_printk(), 
   for example), and although its not addressed explicitly here, this proposal does
   not preclude the handling of multi-line messages/events.
