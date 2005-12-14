Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVLNQs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVLNQs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVLNQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:48:26 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:10185 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964856AbVLNQsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:48:25 -0500
Message-ID: <43A04CEB.60803@de.ibm.com>
Date: Wed, 14 Dec 2005 17:48:43 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [patch 5/6] statistics infrastructure - documentation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... remainder of patch 5/6

[patch 5/6] statistics infrastructure

This is the documentation for developers.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  00-INDEX       |    2
  statistics.txt |  629 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 631 insertions(+)

diff -Nurp e/Documentation/00-INDEX f/Documentation/00-INDEX
--- e/Documentation/00-INDEX	2005-12-14 12:51:13.000000000 +0100
+++ f/Documentation/00-INDEX	2005-12-14 14:22:54.000000000 +0100
@@ -264,6 +264,8 @@ stable_kernel_rules.txt
  	- rules and procedures for the -stable kernel releases.
  stallion.txt
  	- info on using the Stallion multiport serial driver.
+statistics.txt
+	- info on statistics infrastructure available for drivers and others
  svga.txt
  	- short guide on selecting video modes at boot via VGA BIOS.
  sx.txt
diff -Nurp e/Documentation/statistics.txt f/Documentation/statistics.txt
--- e/Documentation/statistics.txt	1970-01-01 01:00:00.000000000 +0100
+++ f/Documentation/statistics.txt	2005-12-14 14:22:54.000000000 +0100
@@ -0,0 +1,629 @@
+
+  Statistics infrastructure
+
+0. Which problems is it meant to solve?
+1. Concept
+2. Advantages of a generic approach
+3. Disadvantages of a generic approach
+4. Features
+5. User interface
+6. Programming interface
+7. Possible future enhancements / known bugs
+8. Contact
+
+
+
+
+  0. Which problems is it meant to solve?
+
+This common code layer implements statistics in a device driver independent
+and architecture independent way.
+
+It targets kernel programmers (mostly device driver programmers) who think about
+providing statistics for their driver and devices, and who look for an
+alternative to the reinvent-the-wheel approach.
+
+This layer tries to minimize the effort imposed on programmers implementing
+statistics. It is not meant to support the proliferation of unnecessary
+statistics, though.
+
+It also tries to solve the problem of different user interfaces for the various
+device drivers implementing statistics.
+
+
+
+
+  1. Concept
+
+	Overview
+
+The following figure tries to depict how the statistics infrastructure
+fits into the global picture, and how it interacts with both exploiting
+kernel code as well as users.
+
+ USER          :                        KERNEL
+               :
+          user         statistics            programming
+          interface    infrastructure        interface    exploiter
+               :       +------------------+       :       +-----------------+
+               :       | process data and |       :       | collect and     |
+ "data"        :       | provide output   |     (X, Y)    | report data     |
+  <====================| to user          |<==============| as (X, Y) pairs |
+ file          :       |         ^        |       :       |                 |
+               :       |         ^        |       :       |                 |
+               :       |         ^        |       :       |                 |
+               :       |         ^        |       :       | create/discard  |
+ "definition"  :       | display settings |       :       | statistics,     |
+  <===================>| and accept       |<==============| provide default |
+ file          :       | changed settings |       :       | settings        |
+               :       +------------------+       :       +-----------------+
+               :                                  :
+
+Actual semantics of the data that feeds a statistic is unimportant when it
+comes to data processing. All that matters is how the user wants the data to
+be presented (counters, histograms, and so on). That's something that can be
+dealt with by a generic layer without intervention by the device driver
+being the source of data.
+
+It's like a cow giving milk. Every time some milk has been gathered
+it is rushed to the dairy. Its not the cow's business to worry about
+the various products made of milk and how these products are packaged
+and delivered. Nor is it the business of sheep or goat, for that
+matter. It's a question of customer demand observed by the dairy
+whether milk is sold as cheese, yogurt, cream,... or simply milk.
+
+
+	The role of the statistics infrastructure
+
+It is the statistic infrastructure's task to accept or drop, accumulate,
+compute and store, as well as display statistics data according to the
+current settings.
+
+
+	The role of exploiters
+
+It is the exploiter's (e.g. device driver's) responsibility to feed the
+statistics infrastructure with sampled data for the statistics maintained by the
+statistics infrastructure on behalf of the exploiter.
+
+It would be nice of any exploiter to provide a default configuration for each
+statistic that most likely works best for general purpose use.
+
+
+	The role of users
+
+It is the user's freedom to configure how accumulation, computation and
+display of data are done, according to their needs.
+
+
+	How data is reported
+
+Exploiters report data bits in the form of (X, Y) with X being a numerical
+value for the main characteristic of the statistic, like a request size or
+request latency, and with Y being a qualifier for that characteristic,
+for example occurrence of a particular X-value.
+
+
+	How data is processed
+
+(X, Y) pairs can be processed in different ways by the statistics
+infrastructure, according to the current settings applicable to a
+particular statistic.
+
+For example, Y-parts can summed up using a simple counter, which,
+in case of a (request size, occurrence)-statistic, would yield the
+total of requests observed.
+
+Or, a simple counter can be the sum of all X*Y products, which,
+in case of a (request size, occurrence)-statistic, would yield the
+total of bytes transfered.
+
+Or, the X-value could be used, sticking to the example above, to distinguish
+request sizes and, therewith, to determine the occurrence of certain request
+sizes. This can be accomplished by the histogram functions of the statistics
+infrastructure.
+
+There are more ways of data processing implemented.
+All these algorithms are documented as part of the programming interface.
+Please note that the statistics infrastructure does not care about the
+actual semantics of (X, Y), an that it just adheres to abstract rules
+describing what to do with (X, Y) pairs for certain settings.
+It is up to the user to interpret processed data, to add semantics
+back to it, and to choose settings and, therewith, data processing modes
+according to their needs.
+
+
+	More design points
+
+Statistics can be grouped within "interfaces" (debugfs entries), in order to
+reflect collections of related statistics of an entity, to allow for coherence
+across statistics of an entity when being read by users, and in order not to
+"pollute" debugfs.
+
+The statistics infrastructure provides multiple "views" on the same data or
+statistic respectively (called "definition", or settings in this document),
+or to be precise, multiple ways to process that data at run-time.
+The way data processing is done impact impacts the output format.
+The current implementation only allows to apply a one
+"view" / definition to a statistic to any point in time.
+
+ statistics infrastructure
+    |
+    +----- statistic interface
+    |         |
+    |         +----- statistic
+    |         |        (comprising definition and data)
+    |         |
+    |         +----- statistic
+    |         |
+    |         :
+    |
+    |
+    +----- statistic interface
+    |         |
+    |         +----- statistic
+    |         |
+    :         :
+
+
+Statistics are off by default. Starting and stopping is independent from
+resetting a statistic's data.
+
+
+
+
+  2. Advantages of a generic approach
+
+Apart from a cleaner design approach, other advantages include:
+
+	Reduced development and test effort
+
+Once the generic layer was almost finished (using a test module),
+implementation and test of an assortment of statistics for the zfcp
+driver took me about 2 days. I spend more time evaluating which
+statistics make sense and which don't than coding the device driver
+extension.
+
+This makes it also cheap to put private patches for performance
+debugging purposes together which can be thrown away once the
+performance problem is understood.
+
+By not putting the statistics code into the device driver,
+I separated about 90 percent of it out into a reusable layer, which
+has seen some testing that the next exploiter can rely on.
+
+
+	Common user interface
+
+There is no point in coming up with another user interface and
+new algorithms for data processing for every device driver that
+is going to implement statistics.
+
+Once a user has learned to read and adjust statistics of component A
+they will have little or no problems applying this knowledge to
+statistics of component B.
+
+Besides, I can imagine a single script that would suffice to generate
+input for the spreadsheet program of your choice from statistics output
+of any component.
+
+
+	Lots of features
+
+The generic layer provides a superset of features of the
+"reinventing the wheel"-statistics I am aware of. This includes many
+ways data processing can be done. It's all there for everybody.
+
+It also means plenty of flexibility from a users perspective, because
+there are enough knobs available that make it unnecessary for me to
+respond to requests like "Hey, could you rebuild the zfcp module
+for me, because I need a finer resolution for that latency histogram?"
+
+
+
+
+  3. Disadvantages of a generic approach
+
+Well, disadvantages center about performance. Some people might feel strong
+about it, while others don't have any issues with it.
+I am listing here what has come to my mind, anyway.
+
+While the code has been written to be as concise as possible,
+some programmers might feel the statistics infrastructure are
+overkill for their purposes. For example, if they think they can do
+with a simple atomic_t, they might frown upon statistic_add().
+
+The statistic infrastructure doesn't make use of in-line assemblies, which might
+be faster than the architecture independent C code. Maybe some programmers would
+rather opt for some small in-line assembly for their own specific purposes.
+
+Because of the flexibility as to the various knobs available for adjusting
+statistics (ranges, resolution or precision, mode of data processing, ...)
+it is up to the statistics infrastructure to take some decisions at run time
+(if this setting do that data processing), which, therewith, can't be resolved
+and optimized by the compiler. Flexibility and functionality are achieved on
+the expense of slightly increased path length.
+
+
+
+
+  4. Features
+
+	Modes of data processing
+
+The simplest type of statistic is called "value" that provides either the total
+of Y-values, or the total of X*Y products using a simple counter.
+
+Another type that does require little memory is called "range" and comprises a
+set of four values: number, minimum, average, and maximum. It is a nice fill
+level indicator.
+
+Then, there are two types of histograms, one where Y-values are summed up for
+each X-value observed (called "list" because it utilizes an adaptable
+list_head list), and another one where Y-values are added up for ranges or
+intervals of X-values (called "array" because it utilizes a fixed-size array).
+"array"-type statistics can have either a linear or logarithmic X-scale.
+
+The statistic type "history" enhances other basic types ("value" and "range")
+by the dimension time. It allows to generate statistic results for successive
+periods of time, and it provides a history of these results. For example,
+transfer rate over time, like bytes/second, can be shown this way for a
+(request size, occurrence)-like data feed.
+
+Finally, there is a type called "raw" which simply stores timestamped (X, Y)
+pairs in a ring-buffer.
+
+Details on each type and the associated algorithms can be found in the
+kernel-doc-style comments of the programming interface.
+
+The statistics infrastructure has been designed to allow for easy addition of
+more types.
+
+
+	Other things that can be adjusted
+
+Ranges of acceptable X-values of (X, Y) pairs can be adjusted to the users
+needs. For example, a certain range of latencies could be of interest for a
+(request latency, occurrence)-like data source.
+
+Data can be discarded by users by resetting the statistic.
+
+Data gathering can be turned on and off for each statistic individually, or
+in an atomic fashion for all statistics attached to an interface.
+
+
+
+
+  5. User interface
+
+	Locating statistics
+
+The statistics infrastructure's user interface is in the
+/sys/kernel/debug/statistics directory, assuming debugfs has been mounted at
+/sys/kernel/debug.  The "statistics" directory holds interface subdirectories
+created by exploiters, for example:
+
+  drwxr-xr-x 2 root root 0 Jul 28 02:16 zfcp-0.0.50d4
+
+An interface subdirectory contains two files, a data and a definition file:
+
+  -r-------- 1 root root 0 Jul 28 02:16 data
+  -rw------- 1 root root 0 Jul 28 02:16 definition
+
+The data file holds the statistic data collected in ASCII format. Each
+line contains one entry of a statistic, tagged with the statistic name,
+for example:
+
+  request_sizes_scsi_write 0x1000 34
+
+You can influence the output in the data file by setting attributes in
+the definition file.
+
+
+	The "definition" file
+
+The statistics infrastructure processes reported data according to the
+settings in the definition file, particularly the type attribute. You
+can change some statistic attributes and thereby change how data is
+processed.
+
+The definition file contains the name, type, mode and other definitions
+for the different statistics for which data are collected. For example,
+a entry for a statistic in a definition file might look like this:
+
+  # cat definition
+  name=util_qdio_outb on=0 type=history range_min=0 range_max=127
+  entries_max=128 mode=range period=1000000 hits_out_of_range=0
+  data=[2417020.832398] started=[2417044.149675] stopped=[2417020.832398]
+  units=slots-occupied/incidents
+
+Some of the attributes shown are common to all statistics, others only apply
+to specific statistic type or mode of data processing respectively. Many
+attributes can be changed by users, others are read-only. All timestamps
+are in the style of printk-timestamps.
+
+
+	Common statistic attributes
+
+  Attribute	Changeable	Comment
+
+  name		No		The device driver provides the name that defines
+				a statistic.
+
+  units		No 		Units defines what the device driver reports
+				as (X, Y) pair.
+
+  type		Yes		The attribute determines the way sampled data
+				is processed and displayed. Valid values are:
+				value, range, array, list, history, raw
+
+  data 		Yes 		The age of sampled data, that is, the time
+				since last reset.
+
+  on 		Yes 		The on or off state. Valid assignments are
+				0 (off) and 1 (on).
+
+  started 	No 		The last time the statistic was started.
+				Depends on the on attribute.
+
+  stopped 	No 		The last time the statistic was stopped.
+				Depends on the on attribute.
+
+  range_min 	Yes 		The minimum value of the range you are
+				interested in.
+
+  range_max 	Yes 		The maximum value of the range you are
+				interested in.
+
+  hits_out_of_range 	No 	Values smaller than range_min and larger than
+				range_max are counted here.
+
+
+	Attributes specific to particular statistic types
+
+  Attribute	Specific to 	Changeable 	Comment
+
+  entries_max 	type=history    Yes		Maximum number of entries in a
+		type=list			ring buffer or list.
+		type=raw
+
+  hits_missed 	type=list 	No 		Number of (X, Y) pairs missed
+						due to a list-size limit
+						imposed by entries_max.
+
+  scale 	type=array 	Yes 		Valid values are:
+						lin for linear scale,
+						log2 for logarithmic scale.
+
+  base_interval type=array 	Yes 		base interval used for X-scale
+
+  mode=increments 		Yes		Mode determines that only the
+		type=history			total of Y-value is to be
+		type=value 	Yes		calculated.
+
+  mode=products type=history	Yes		Mode determines that the total
+		type=value 	Yes 		of X*Y products is to be
+						calculated.
+
+  mode=range 	type=history 	Yes 		Mode determines that a set of
+						(number, min, average, max) is
+						to be calculated for each
+						period shown in the history
+						ring-buffer.
+
+  period 	type=history 	Yes 		Determines the time to elapse
+						before calculation is started
+						over.
+
+
+	Changing attributes through the "definition" file
+
+A statistic can be reconfigured by writing changed attributes to the
+definition-file:
+
+  echo name=foobar type=list entries_max=256 > definition
+
+You can either write the entire line describing a statistic, including
+read-only attributes (which are ignored by the statistics infrastructure, as
+any other junk is). This simplifies the procedures (copy, paste to command line,
+modify command line, echo attributes from command line into definition file)
+and (cat to file, modify file content, cat file back into definition file).
+
+In many cases, there is no need to write all attributes of a statistic back.
+Many attributes can be changed by themselves or when combined with other
+independent attributes:
+
+  echo name=foo range_min=3 > definition
+
+  echo name=foo range_max=17 > definition
+
+  echo name=bar on=1 > definition
+
+Only if you change the type of a statistic you are required to provide all
+type-specific attributes, because the type-specific attributes of the old type
+do not apply anymore:
+
+  echo name=foobar type=history mode=range period=1000000 entries_max=1024
+   > definition
+
+Naturally, changes of the type of a statistic or of type-specific attributes
+causes all data to be discarded and calculations being started over.
+
+Some operations can be done in an atomic fashion for all statistics grouped
+within the scope of an interface. Simply, omit the name= attribute:
+
+  echo on=1 > definition
+
+  echo on=0 > definition
+
+  echo data=reset > definition
+
+
+	Reading statistic output from the "data" file
+
+The "data" file contains the output of all statistics available for a
+particular interface. This is an ASCII file. Depending on the type of a
+statistic, the output for a statistic consists of a single line or a bunch
+of lines. Each line delivers one value or one result of a statistic and
+consists of several strings separated by spaces. The beginning of each line
+is tagged with the name of the statistic the line belongs to. The rest of
+a line is statistic-type specific. The content of a "data" might look like
+this:
+
+  foo 0x1000 4
+  foo 0x2000 1
+  foo 0x5000 2
+  bar 961 1 42.000 128
+
+
+	Output formats of different statistic types
+
+  Statistic Type	Output Format				Number of Lines
+
+  value			<name> <total>				1
+
+  range			<name> <total> <min> <avg> <max>	1
+
+  list			<name> <Xn> <total for Xn>		<= entries_max
+			...
+
+  array			<name> "<="<Xn> <total for interval>    number of
+			...					intervals as
+			<name> ">"<Xm> <total for interval>	determined by
+								base_interval,
+								scale,
+								range_min,
+								range_max
+
+  history		<name> <time-stamp> <total>		<= entries_max
+  (mode=increments,	...
+   mode=products)
+
+  history		<name> <time-stamp> <total> <min> <avg> <max>
+  (mode=range)		...					<= entries_max
+
+  raw			<name> <time-stamp> <serial> <X> <Y>	<= entries_max
+			...
+
+	Sample Output
+
+This is output from per-adapter statistics of the zfcp SCSI HBA driver.
+It shows data for 5 statistics:
+
+  occurrence_qdio_outb_full 57
+  util_qdio_outb [3097301.211992] 0 0 0.000 0
+  ...
+  util_qdio_outb [3097394.211992] 865 1 1.052 5
+  util_qdio_outb [3097395.211992] 737 1 4.558 125
+  util_qdio_outb [3097396.211992] 396 1 11.765 77
+  util_qdio_outb [3097397.211992] 270 1 12.863 128
+  util_qdio_outb [3097398.211992] 765 1 7.271 26
+  util_qdio_outb [3097399.211992] 577 1 4.036 27
+  util_qdio_inb 118706 1 1.017 31
+  occurrence_low_mem_scsi 0
+  occurrence_erp 0
+
+In the order of appearance there are:
+
+  a value-type statistic providing a simple counter,
+  a history-of-ranges-type statistic providing a fill level indicator
+	over time (one entry per second),
+  a range-type statistic providing a fill level indicator,
+  two more value-type statistics.
+
+Here is more data for the same device driver (data per LUN):
+
+  request_sizes_scsi_write 0x64000 13
+  ...
+  request_sizes_scsi_write 0x67000 9
+  request_sizes_scsi_write 0x73000 8
+  ...
+  request_sizes_scsi_write 0x7b000 5
+  request_sizes_scsi_read 0x1000 44163
+  request_sizes_scsi_read 0x2000 9281
+  request_sizes_scsi_read 0x3000 4860
+  request_sizes_scsi_read 0x8000 4682
+  ...
+  request_sizes_scsi_read 0x4000 2976
+  request_sizes_scsi_nodata 0
+  latencies_scsi_write <=0 0
+  latencies_scsi_write <=1 0
+  latencies_scsi_write <=2 0
+  latencies_scsi_write <=4 174
+  latencies_scsi_write <=8 872
+  latencies_scsi_write <=16 2555
+  latencies_scsi_write <=32 2483
+  ...
+  latencies_scsi_write <=1024 1872
+  latencies_scsi_write >1024 1637
+  latencies_scsi_read <=0 0
+  latencies_scsi_read <=1 0
+  latencies_scsi_read <=2 0
+  latencies_scsi_read <=4 57265
+  latencies_scsi_read <=8 13610
+  latencies_scsi_read <=16 1082
+  latencies_scsi_read <=32 319
+  latencies_scsi_read <=64 63
+  ...
+  latencies_scsi_read >1024 0
+  latencies_scsi_nodata <=0 0
+  ...
+  latencies_scsi_nodata >1024 0
+  pending_scsi_write 17121 1 28.502 32
+  pending_scsi_read 72348 3 3.002 5
+
+In the order of appearance there are:
+
+  two lists of request sizes and their occurrences (write, read),
+  a counter for commands without data transfer,
+  three array-type histograms with logarithmic scales for request latencies
+	in milliseconds (write, read, no data),
+  two range-type statistics indicating many SCSI commands are pending
+	concurrently (write, read).
+
+
+
+
+  6. Programming interface
+
+The programming interface can be retrieved from the kernel-doc-style comments
+available for all interface functions. A programming example can be found in
+drivers/s390/scsi.
+
+Anyway, here is an introduction:
+
+First, call statistic_create_interface() in order to create an interface
+where several statistics for the concerned entity can be attached next by
+calling statistic_create(). It is recommended that you call
+statistic_define_*() for each statistic, as well, in order to provide some
+half-decent default settings for the newly created statistic.
+
+Usually, exploiters won't enable data gathering - by calling statistic_start() -
+unless data should be collected by default. In many cases, it might be better
+to leave this to users, who can start statistics any time they wish.
+
+Add statistic_add*() or statistic_inc*() calls where appropriate for
+reporting statistics data. Data to be reported through these functions has the
+form of (X, Y) as explained above.
+
+In order to remove statistics call statistic_remove().
+The function statistic_interface_remove() cleans up an entire interface with
+all statistics still attached.
+
+
+
+
+  7. Possible future enhancements / known bugs
+
+The current implementation is a prototype. It is good enough for the current
+zfcp requirements, though. For general use more work might be required.
+
+There are several possible enhancements and optimizations documented
+at the head of lib/statistic.c There I keep track of bugs as well.
+
+
+
+
+  8. Contact
+
+See MAINTAINERS file.
