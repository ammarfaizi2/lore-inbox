Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWESQMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWESQMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWESQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:12:17 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:3861 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932436AbWESQMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:12:15 -0400
Subject: [Patch 4/6] statistics infrastructure - documentation
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 18:12:12 +0200
Message-Id: <1148055132.2974.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

documentation for developers and users

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 00-INDEX       |    2
 statistics.txt |  741 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 743 insertions(+)

diff -Nurp a/Documentation/00-INDEX b/Documentation/00-INDEX
--- a/Documentation/00-INDEX	2006-03-20 06:53:29.000000000 +0100
+++ b/Documentation/00-INDEX	2006-05-19 16:02:09.000000000 +0200
@@ -264,6 +264,8 @@ stable_kernel_rules.txt
 	- rules and procedures for the -stable kernel releases.
 stallion.txt
 	- info on using the Stallion multiport serial driver.
+statistics.txt
+	- info on statistics infrastructure available for drivers and others
 svga.txt
 	- short guide on selecting video modes at boot via VGA BIOS.
 sx.txt
diff -Nurp a/Documentation/statistics.txt b/Documentation/statistics.txt
--- a/Documentation/statistics.txt	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/statistics.txt	2006-05-19 16:23:32.000000000 +0200
@@ -0,0 +1,741 @@
+
+  Statistics infrastructure
+
+0. Which problems is it meant to solve?
+1. Concepts
+2. Performance
+3. Modes of data processing
+4. User interface
+5. Programming interface
+6. Possible future enhancements and known bugs
+7. Contact
+
+
+
+
+  0. Which problems is it meant to solve?
+
+This common code layer implements statistics in a device driver independent
+and architecture independent way. It minimizes the effort by providing a simple
+programming interface. Added benefit is a generic user interface.
+
+
+
+
+  1. Concepts
+
+	Overview
+
+The following figure depicts how the statistics infrastructure
+fits into the global picture, and how it interacts with both exploiting
+kernel code as well as users.
+
+ USER	       :			KERNEL
+	       :
+	  user	       statistics	     programming
+	  interface    infrastructure	     interface	  exploiter
+	       :       +------------------+	  :	  +-----------------+
+	       :       | process data and |	  :	  | collect and     |
+ "data"        :       | provide output   |	(X, Y)	  | report data     |
+  <====================| to user	  |<==============| as (X, Y) pairs |
+ file	       :       |	 ^	  |	  :	  |		    |
+	       :       |	 ^	  |	  :	  |		    |
+	       :       |	 ^	  |	  :	  |		    |
+	       :       |	 ^	  |	  :	  | create/discard  |
+ "definition"  :       | display settings |	  :	  | statistics,     |
+  <===================>| and accept	  |<==============| provide default |
+ file	       :       | changed settings |	  :	  | settings	    |
+	       :       +------------------+	  :	  +-----------------+
+	       :				  :
+
+Actual semantics of the data that feeds a statistic is unimportant when it
+comes to data processing. All that matters is how the user wants the data to
+be presented (counters, histograms, and so on). That's a job that can be
+be done by a generic layer without intervention by the device driver
+which is the actual source of statistics data.
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
+	The form of reported data
+
+Exploiters report data in the form of (X, Y) value pairs with X being
+a quantity for the main characteristic of the statistic, like a request size
+or request latency, and with Y being a qualifier for that characteristic,
+i.e. the occurrence of a particular X-value.
+
+Thus, the Y-part can be seen as an optimisation that allows exploiters
+to report a bunch of similar measurements in one call (see statistic_add()).
+For the programmer's convenience, Y can be omitted when it would be always 1
+(see statistic_inc()).
+
+
+	How data is reported
+
+There are two methods how such data can be provided to the statistics
+infrastructure, a push interface and a pull interface. Each statistic
+is either a pull-type or push-type statistic as determined by the exploiter.
+
+The push-interface is suitable for data feeds that report incremental updates
+to statistics, and where actual accumulation can be left to the statistics
+infrastructure. New measurements usually trigger pushing data.
+(see statistics_add() and statistic_inc())
+
+The pull-interface is suitable for data that already comes in an aggregated
+form, like hardware measurement data or counters already maintained and
+used by exploiters for other purposes. Reading statistics data from files
+triggers an optional callback of the exploiter, which can update pull-type
+statistics then (see statistic_set()).
+
+
+	How data is processed
+
+(X, Y) pairs can be processed in different ways by the statistics
+infrastructure, according to the current settings applicable to a
+particular statistic.
+
+For example, X might be used to distinguish certain buckets (see histogram).
+Minimum, average and maximum X values might be determined (see utilisation).
+Y might be summed up (see counter, for example).
+
+See below for a reference of processing options.
+
+Please note that the statistics infrastructure does not care about the
+actual semantics of (X, Y), and that it just adheres to abstract rules
+describing what to do with (X, Y) pairs for certain settings.
+It is up to the user to interpret processed data, to add semantics
+back to it, and to choose settings and, therewith, data processing modes
+according to their needs.
+
+
+	How statistics are organised
+
+Statistics are grouped within "interfaces" (debugfs entries) by exploiters,
+in order to reflect collections of related statistics of an entity,
+which is also quite efficient with regard to memory use.
+
+ statistics infrastructure
+    |
+    +----- statistic interface
+    |	      |
+    |	      +----- statistic
+    |	      |        (comprising definition and data)
+    |	      |
+    |	      +----- statistic
+    |	      |
+    |	      +----- statistic
+    |	      |
+    |	      :
+    |
+    |
+    +----- statistic interface
+    |	      |
+    |	      +----- statistic
+    |	      |
+    :	      :
+
+The user interface, the programming interface and the internal data
+structures are organised like this.
+
+
+	Why debugfs for now
+
+While sysfs comes with a refined structure reflecting almost everything
+in the system, it is (by design) not good at representing large and variable
+amounts of data, that is, more than one value per file. As for statistics,
+we could make good use of the former, but not of the latter.
+
+For example, the same statistic might work as a single counter, or as a
+histogram comprising a variable (user-defined) number of buckets, or as an
+adaptable list of buckets for sparse concrete values, etc. Whatever the result
+looks like should be left to the individual modes of data processing.
+In order to reduce all kinds of data processing and their output to a common
+denominator, an output format along the following lines is suggested and
+has been implemented:
+
+  latency_write <=0 0			\
+  latency_write <=1 13			|
+  latency_write <=2 13			|
+  latency_write <=4 56			|
+  latency_write <=8 144			|
+  latency_write <=16 184		| a histogran with
+  latency_write <=32 181		> 13 buckets
+  latency_write <=64 74			|
+  latency_write <=128 271		|
+  latency_write <=256 0			|
+  latency_write <=512 33		|
+  latency_write <=1024 0		|
+  latency_write >1024 0			/
+  latency_read <=0 0				\
+  ...						> another histogram
+  latency_read >1024 0				/
+  size_write missed 0x0			\
+  size_write 0x1000 143			|
+  size_write 0xc000 42			|
+  size_write 0x10000 14			| an adaptable list
+  size_write 0xf000 13			> with a growing number of buckets
+  size_write 0x1e000 12			| (up to a defined limit only)
+  size_write 0x14000 12			|
+  ...					|
+  size_write 0x9000 1			/
+  queue_used_depth 970 1 18.122 32		> num min avg max for a queue
+
+Such output can grow as needed in debugfs files. It is human-readable and
+could be parsed and postprocessed by simple scripts that are aware of what the
+output of the various data processing modes looks like.
+
+
+	State machine
+
+Each statistic has a state that should be initialised by exploiters.
+Users probably want to adjust this state, e.g. enable
+data gathering. Defined states and transitions are:
+
+  state=unconfigured	(mode of data processing has not yet been defined)
+	A
+	|
+	|
+	V
+  state=released	(mode of data processing has been defined, but memory
+	A		 required for data gathering has not yet been allocated
+	|		 - would be a good default setup provided by exploiters)
+	|
+	V
+  state=off		(all memory required for the defined mode of data
+	A		 processing has been allocated, but data gathering is
+	|		 currently disabled - data available to users, though)
+	|
+	V
+  state=on		(data gathering is enabled and being done according to
+			 the currently defined processing mode - data available
+			 to users)
+
+How to alter states is explained in the user interface section of this document.
+
+
+
+
+  2. Performance
+
+
+	Some preliminary numbers
+
+FIXME
+
+	Per-CPU data
+
+Measurements reported by exploiters are accumulated into per-CPU data areas
+in order to avoid the introduction of serialisation during the
+execution of statistic_add(). Locking of per-CPU data is done by disabling
+preemption and interrupts per CPU for the short time of a statistic update.
+
+Per-CPU data is not used if a statistic doesn't collect incremental data,
+i.e. if is only updated using statistic_set().
+
+
+	Path length of statistic_add() & friends
+
+Some flexibility and functionality are achieved on the expense of slightly
+increased path length.
+
+A function pointer is used to implement different data processing modes
+users can choose from.
+
+Individual data processing modes might come with their particular knobs,
+e.g. resolution or precision. That means that the statistics infrastructure
+has to retrieve some values required for calculation at run time.
+
+
+	Memory footprint
+
+Because the statistics code uses per-CPU data, it observes CPU hot-(un)plug
+events and allocates and releases per-CPU data as sparingly as possible.
+
+The differentiation of:
+
+- struct statistic (any data required for gathering data for a statistic),
+- struct statistic_info (description of a class of statistics),
+- struct statistic_discipline (description of a data processing mode), and
+- struct statistic_interface (user interface for a collection of statistics)
+
+means avoidance of storing redundant data per statistic. Struct statistic
+can be kept quite small.
+
+
+	Disabling statistics
+
+Data gathering can be turned off (by default or by users), which reduces
+statistic_add() to a check.
+
+
+	Kernel configuration option
+
+CONFIG_STATISTICS can be used to include or exclude statistics during the
+kernel build process.
+
+
+
+
+  3. Modes of data processing
+
+So far, available are:
+
+
+	type=counter_inc
+
+A counter sums up all Y-values of (X, Y) data pairs reported, regardless of the
+X-part.
+
+For example, a (request size, occurrence)-statistic would yield the
+total of requests observed.
+
+
+	type=counter_prod
+
+A counter sums up all X*Y with X and Y belonging to the same (X, Y).
+
+For example, a (request size, occurrence)-statistic would yield the
+total of bytes transfered.
+
+
+	type=utilisation
+
+Provides a set of values comprising:
+- the sum of all Y-values,
+- the minimum X
+- the average X
+- the maximum X
+
+This appears to be a useful fill level indicator for queues etc.
+
+For example, a (request size, occurrence)-statistic would yield a very
+basic statement about the traffic pattern, with information about the range
+of request sizes observed.
+
+
+	type=histogram_lin
+
+Comprises a set of counters, with each counter summing up all those Y-values
+reported for an assigned range or interval of X-values. All intervals of
+X-values are equal.
+
+Additional required parameters include:
+- entries (number of buckets, at least 2 required)
+- range_min (first bucket stands for <=range_min)
+- base_interval (interval size each bucket covers)
+
+For example, a (request size, occurrence)-statistic would yield a histogram
+of observed request sizes, with the same precision for small, medium and
+large request sizes.
+
+
+	type=histogram_log2
+
+Similar to type=histogram_lin, except that the intervals double
+from bucket to bucket. That is, the histogram loses in precision for
+larger X-values.
+
+
+	type=sparse
+
+This one is similar to other histograms, with the exception that it provides
+buckets for discrete X-values instead of ranges of X-values. Since it
+utilises a list instead of an array, it is suited for compiling histogram-like
+results for rather few, sparse X-values which users want to measure
+separately.
+
+Additional required parameters include:
+- entries (list is capped at this number of entries)
+
+For example, a (request size, occurrence)-statistic would yield the
+occurrences of all request sizes. Since it records precise sizes,
+it can also show the odd one out, which might be problematic; who knows...
+
+
+	Other
+
+The statistic infrastructure has been designed to make the addition
+of more ways of data processing easy (see struct statistic_discipline).
+
+For example, two more types had been implemented which are not included
+in the source code:
+
+- A "raw" type statistic which provides a record of (X, Y)-pairs.
+  Nice for verification and debugging purposes.
+
+- An enhancement of other basic types, like "counter" or "utilisation"
+  by the dimension time, which provides a time-tagged history of their
+  results for successive periods of time.
+  For example, a (request size, occurrence)-statistic could yield the
+  transfer rate over time, like bytes per second.
+
+
+
+
+  4. User interface
+
+	Locating statistics
+
+The statistics infrastructure's user interface is in the
+/sys/kernel/debug/statistics directory, assuming debugfs has been mounted at
+/sys/kernel/debug.  The "statistics" directory holds interface subdirectories
+created on the behalf of exploiters, for example:
+
+  drwxr-xr-x 2 root root 0 Jul 28 02:16 zfcp-0.0.50d4
+
+An interface subdirectory contains two files, a data and a definition file:
+
+  -r-------- 1 root root 0 Jul 28 02:16 data
+  -rw------- 1 root root 0 Jul 28 02:16 definition
+
+
+	The "definition" file
+
+The statistics infrastructure processes reported data according to the
+settings in the definition file, particularly the type attribute. You
+can change some statistic attributes and thereby change how data is
+processed.
+
+Some of the attributes shown are common to all statistics, others only apply
+to specific statistic type of data processing (see there for description).
+Some attributes can be changed by users, others are read-only. All timestamps
+are in the style of printk-timestamps.
+
+
+	Common statistic attributes
+
+  Attribute	Changeable	Comment
+
+  name		No		The device driver provides the name that
+				defines a statistic.
+
+  units		No		Units defines what the device driver reports
+				as (X, Y) pair.
+
+  state		Yes		Valid assignments are
+				on, off, released, unconfigured.
+				Note: Transition from unconfigured requires
+				the specification of type and all
+				additional attributes for that type.
+
+  type		Yes		The attribute determines the way sampled data
+				is processed and displayed. See corresponding
+				section in this document for valid assignements.
+
+  data		No		The age of sampled data, that is, the time
+				since last reset.
+
+  started	No		The last time the statistic was started.
+				Depends on the state attribute.
+
+  stopped	No		The last time the statistic was stopped.
+				Depends on the state attribute.
+
+
+	Changing statistics
+
+Here are some commented examples. This is how we start off:
+
+  [scsi-0:0:0:0]# head -n 1 definition
+  name=issued_write state=off units=bytes/request type=sparse entries=256
+  data=[7283835.951603] started=[7283835.951604] stopped=[7283856.502492]
+
+Let's get rid of any data and setup for this particular statistic:
+
+  [scsi-0:0:0:0]# echo name=issued_write state=unconfigured > definition;
+  head -n 1 definition
+  name=issued_write state=unconfigured units=bytes/request
+
+Redefine the statistic without enabling data gathering:
+
+  [scsi-0:0:0:0]# echo name=issued_write type=utilisation > definition;
+  head -n 1 definition
+  name=issued_write state=released units=bytes/request type=utilisation
+
+Enable data gathering:
+
+  [scsi-0:0:0:0]# echo name=issued_write state=on > definition;
+  head -n 1 definition
+  name=issued_write state=on units=bytes/request type=utilisation
+  data=[7284319.773163] started=[7284319.773170] stopped=[7283856.502492]
+
+Discard data without changing any settings (note the time stamps):
+
+  [scsi-0:0:0:0]# echo name=issued_write data=reset > definition;
+  head -n 1 definition
+  name=issued_write state=on units=bytes/request type=utilisation
+  data=[7284495.638893] started=[7284495.638894] stopped=[7284495.638844]
+
+Change statistic back to defaults as provided by device driver:
+(Note this discards all data.)
+
+  [scsi-0:0:0:0]# echo name=issued_write defaults > definition;
+  head -n 1 definition
+  name=issued_write state=on units=bytes/request type=sparse entries=256
+  data=[7284603.624271] started=[7284603.624273] stopped=[7284603.624199]
+
+Change a type specific attribute - here, reduce maximum list size:
+(Note this discards all data.)
+
+  [scsi-0:0:0:0]# echo name=issued_write entries=16 > definition;
+  head -n 1 definition
+  name=issued_write state=on units=bytes/request type=sparse entries=16
+  data=[7285008.933757] started=[7285008.933758] stopped=[7285008.933699]
+
+Turn data gathering off and release all resources allocated:
+
+  [scsi-0:0:0:0]# echo name=issued_write state=released > definition;
+  head -n 1 definition
+  name=issued_write state=released units=bytes/request type=sparse entries=256
+
+One can either write the entire line describing a statistic, including
+read-only attributes (which are ignored by the statistics infrastructure, as
+is any junk). Or one may modify single attributes, assuming this results
+in a valid configuration.
+
+This simplifies the procedures (copy, paste to command line,
+modify command line, echo attributes from command line into definition file)
+and (cat to file, modify file content, cat file back into definition file).
+
+Some operations can be done in an atomic fashion for all statistics grouped
+within the scope of an interface. Simply omit the name= attribute:
+
+  echo state=on > definition
+
+  echo data=reset > definition
+
+  echo defaults > definition
+
+
+	Reading statistic output from the "data" file
+
+The "data" file contains the output of all statistics available through a
+particular interface. File content comes in ASCII. Depending on the type of a
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
+  counter_inc		<name> <total of Y>				1
+
+  counter_prod		<name> <total of Xi*Yi>				1
+
+  utilisation		<name> <total of Y> <min X> <avg X> <max X>	1
+
+  sparse		<name> <Xn> <total of Y for Xn>		<= entries
+			...
+
+  histogram_lin		<name> "<="<Xn> <Y-total for interval>	number of
+  histogram_log2	...					intervals as
+			<name> ">"<Xm> <Y-total for interval>	determined by
+								base_interval,
+								entries and
+								range_min
+
+For sample output please see above.
+
+
+
+
+  5. Programming interface
+
+The programming interface can be retrieved from the kernel-doc-style comments
+available for all interface functions. Programming examples can be found in
+drivers/scsi and drivers/s390/scsi.
+
+
+	Creating statistics
+
+Assuming one wants to embed an array of statistics into a structure
+representing some entity, the following members need to be added:
+
+  struct my_entity {
+	  ...
+	  struct statistic_interface	stat_int;
+	  struct statistic		stat[N];
+  }
+
+stat is an array of N statistics of various sorts.
+
+Since one might want to create several instances of struct my_entity
+each coming with its own set of statistics (stat[N]) setup using the
+same template, provisions for such a template have been made as part of the
+programming interface. An array of struct statistic_info complements an
+array of struct statistic.
+
+  struct statistic_info[] {
+	  { "refund", "cent", "bottle", 0, "type=counter_prod" },
+	  { "fill_level", "millilitre", "bottle", 1, "type=utilisation" },
+	  ...
+  } my_entity_stat_info;
+
+An enum that helps addressing individual statistics of an array comes in handy:
+
+  enum my_entitiy_stat_num {
+	  MY_ENTITY_STAT_REFUND,
+	  MY_ENTITY_STAT_FILL,
+	  ...
+	  N
+  };
+
+Now, here is how to tie the knot for statistics and templates:
+
+  {
+	  struct my_entity *one;
+	  ...
+
+	  /* required */
+	  one->stat_int.stat = one->stat;
+	  one->stat_int.info = my_entity_stat_info;
+	  one->stat_int.number = N;
+
+	  /* Optional callback triggers update of MY_ENTITY_STAT_FILL
+	     when user reads statistic data from file */
+	  one->stat_int.pull = my_entity_pull_fn;
+	  one->stat_int.pull_private = one;
+
+	  retval = statistic_create(&one->stat_int, "bottled_stats");
+	  /* now we can report statistics data */
+	  ...
+  }
+
+
+	Reporting statistics data
+
+Add statistic_add*() or statistic_inc*() calls where appropriate for
+reporting statistics data. Data to be reported through these functions has the
+form of (X, Y) as explained above:
+
+  {
+	  struct my_entity *one;
+	  ...
+
+	  statistic_add(&one->stat, MY_ENTITY_STAT_REFUND, pennies, bottles);
+	  ...
+  }
+
+Which is equivalent to:
+
+  {
+	  struct my_entity *one;
+	  int i;
+	  ...
+
+	  for (i = 0; i < bottles; i++)
+		  statistic_inc(&one->stat, MY_ENTITY_STAT_REFUND, pennies);
+	  ...
+  }
+
+Of course, this example is not optimal. It tries to show how statistic_add() and
+statistic_inc() compare. Sometimes statistic_inc() might be just what you need.
+
+If there is a bunch of statistics to be updated in one go, consider these
+flavours of statistic_add() which require the exploiter to lock per-CPU data
+in one go for improved performance:
+
+  {
+	  struct my_entity *one;
+	  unsigned long flags;
+	  ...
+
+	  local_irq_save(flags);
+	  statistic_inc_nolock(&one->stat, MY_ENTITY_STAT_X, x);
+	  statistic_inc_nolock(&one->stat, MY_ENTITY_STAT_Y, y);
+	  statistic_add_nolock(&one->stat, MY_ENTITY_STAT_Z, z, number);
+	  ...
+	  local_irq_restore(flags);
+  }
+
+The above examples show statistics that feed on incremental updates that
+get accumulated by the statistics infrastructure on top of data already
+gathered by the statistics infrastructure.
+That is why statistic_add() or statistic_inc() respectively are used.
+
+There might be statistics that come as total numbers, e.g. because they feed
+on counters already maintained by the exploiter or some hardware feature.
+These numbers can be exported through the statistics infrastructure along
+with any other statistic. In this case, use statistic_set() to report data.
+Usually it is sufficient to do so when the user opens the corresponding
+file to read statistic data. This will trigger the optional callback function
+to be executed. Place statistic_set() calls there. In the same context calling
+statistic_add() or statistic_inc() for other statistics that feed on
+incremental data works as well, in case that's needed:
+
+  my_entity_stat_pull_fn(void *__one)
+  {
+	  struct my_entity *one = __one;
+	  ...
+
+	  statistic_set(&one->stat, MY_ENTITY_STAT_FILL, one->fill, 1);
+	  ...
+  }
+
+
+	Removing statistics
+
+The function statistic_remove() cleans up an entire interface with
+all statistics attached:
+
+  {
+	  struct my_entity *one;
+	  ...
+
+	  /* by this time we must have ceased reporting statistics data */
+	  retval = statistic_remove(&one->stat_int);
+	  ...
+  }
+
+
+	Adding a another data processing mode
+
+There is a statistics infrastructure internal programmimg interface that
+allows to add other data processing modes fairly easily.
+Please see kernel-doc description of struct statistics_discipline.
+
+
+
+
+  6. Possible future enhancements / known bugs
+
+There are several possible enhancements and optimizations documented
+at the head of lib/statistic.c, where I keep track of bugs as well.
+
+
+
+
+  7. Contact
+
+See MAINTAINERS file.


