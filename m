Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUBZQZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUBZQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:25:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60299 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262803AbUBZQXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:23:50 -0500
Message-ID: <403E1D88.6060107@watson.ibm.com>
Date: Thu, 26 Feb 2004 11:23:36 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [RFC] New API and design for Class-based Kernel Resource Management
Content-Type: multipart/mixed;
 boundary="------------070305070304030907030608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305070304030907030608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's a completely revised user API and high level design of
Class-based Kernel Resource Management. In a nutshell, the project
wants to make resource management easier by introducing explicit support
for classes in the kernel.

Please note that the current design differs significantly from earlier 
versions
which are on the project webpages at http://ckrm.sf.net in two ways: a 
filesystem-based
API is being proposed and classes are  hierarchical.

Feedback on all aspects of the design is welcome !

The project mailing list is ckrm-tech@lists.sf.net.


--Shailabh





--------------070305070304030907030608
Content-Type: text/plain;
 name="CKRMmergedAPI-d6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CKRMmergedAPI-d6.txt"

CKRM (Class-based Kernel Resource Management) 
http://ckrm.sf.net

v4.0 draft 6
25 Feb 2004

Rik van Riel	    riel@redhat.com
Hubertus Franke,    frankeh@watson.ibm.com
Shailabh Nagar      nagar@watson.ibm.com
Vivek Kashyap       kashyapv@us.ibm.com
Chandra Seetharaman sekharan@us.ibm.com

This is the fourth major revision of the CKRM API and framework. The
first was presented at OLS'03, the second is what's described at
http://ckrm.sf.net as of 18 Feb 2004 and the third was sent out on LKML and
ckrm-tech@lists.sf.net on 31 Jan 2004. The fourth version is
based on a merger of best of breed concepts from a filesystem-based
API proposed by Rik van Riel (with inputs from Stephen Tweedie) on the
ckrm-tech mailing list on 5 Feb 2004 and version three of this document.

The project is not committed to a particular API or architecture and
welcomes discussions/comments on the proposal below. Please send feedback
to any of the authors and cc: ckrm-tech@lists.sf.net.

The latest version of the document will be kept at
http://ckrm.sf.net


1.0 Overview
------------

Class-based Kernel Resource Management (CKRM) is a set of modifications to the
Linux kernel to enable improved systems management. The key idea in CKRM is to
control and monitor system resource usage through user-defined groups of tasks
called classes. Classes can be defined to distinguish between applications,
workloads and users in their usage of any system resource such as CPU ticks,
physical page frames, disk I/O bandwidth, accept queue connections, number of
open file handles etc. 



                 
             Sysadmin/resource management application
			    Users       

                syscalls            /rcfs
                  |                  ^          
                  |                  |          
Userspace         V                  V                      
-----------       +------------------+        
Kernel                      |   
                          Core ---- Classification Engine (CE)
                            |
                            |
                 +----------------------------....
                 |     |     |    |         |
                 RC1   RC2   RC3  RC4      RC5 .... RC=Resource Controllers
                 CPU   MEM   I/O  AcceptQ  Open file descriptors, shmsegs etc.
                                        
                                                

The CKRM components are as shown above:

a) Core

Kernel patch that has three key roles. First, it defines the user API
consisting of system calls and a filesystem called rcfs (resource control file
system). Second, it defines the APIs between itself and all other kernel
components namely the resource controllers and the optional classification
engine. Thus the Core acts as the switchboard for users, resource controllers
and classification engines to interact. Finally, Core handles the creation and
management of classes, which are described below.


b) Resource controller (RC)


A kernel patch providing differentiated access to some resource. There can be
multiple RCs defined simultaneously. The CKRM project currently provides CPU
(ticks), Mem (physical page frames), I/O (disk bandwidth) and Inbound Network
(connections) controllers with extensions planned to manage virtual resources
like open file descriptors, shared memory segments etc.


c) Classification Engine (CE)

An optional kernel module that assists in automatic classification of tasks
into classes. A CE will provide a function that returns the class to which a
task "should" belong. The classification function is called by the Core at
significant kernel events (where a task's class might be assigned or expected
to change) and appropriate action taken.

CE's are completely optional. Tasks in the system can also be manually
associated with classes. If a CE exists, it must adhere to the Core-CE
kernel API.

CKRM will provide a rule-based classification engine (RBCE) that performs
classication by evaluating a set of rules entered by a privileged user. 

2.0 Task Classes
--------------------

A task class, commonly abbreviated to just class, is a collection of tasks with
an associated set of shares and usage statistics for each managed resource in
the system. A managed resource (such as CPU, physical memory and disk I/O) is
one whose scheduler or controller is class-aware. 

Each class is associated with a lower and upper bound of resource
usage, called guarantees and limits, for each managed resource in the
system. Guarantees and limits depend on the type of resource and are
described in detail in Section 2.5. The two are collectively called a
share where the distinction is unimportant.

Each task in the system always belongs to some task class. The main
principle behind CKRM is that a task's consumption of managed
resources is controlled (using shares) and monitored (available as a
class' statistics) primarily through the task's class.

The association of tasks to classes is dynamic. A task's classification can be
changed either manually as described Section 2.7, or automatically using a
classification engine as described in Section 4.0.


The task class is used to manage system wide resources.  An alternative type of
class is wholly contained within a task or kernel abstraction (see section
6.0). A socket's accept queue is one such resource that can be used to control
the incoming connection requests.  Unless otherwise specified, a class will
mean a task class.

2.1 Hierarchy of classes
------------------------

Classes are primarily used by sysadmins to monitor and control the
resources used by various workloads running on a system
e.g. mailserver, apache, dns etc. It can also be used to limit and track 
resource usage of users.

In both these cases, it is useful to allow the application or user to manage
its own allocation without having systemwide privileges. To enable this, CKRM
classes can be hierarchically subdivided into subclasses.

Each subclass gets its own share of the parent class' allocation. The
user or workload associated with the parent class can change subclass
shares, monitor subclass usage, effectively managing their allocation
independent of each other and the system administrator.

The depth of the class hierarchy supported by CKRM is configurable. The default
depth is expected to be three though resource controllers will/should be
written to support a reasonably larger number. The maximum depth value allowed
will equal the minimum of the depths supported by any registered
resource controller i.e. if the registered CPU controller can only support a
depth of 2, the user can only configure the depth to be 1 or 2 even if all
other registered controllers can support a depth of 3. 


A depth greater than the default may incur significant performance penalties
and/or relaxation of the time granularity at which shares get enforced. CKRM
will provide helper functions to assist resource controllers traverse the class
hierarchy for control and statistics updation.

2.2 rcfs API overview
---------------------

CKRM's primary user API is the resource control file system (rcfs). A
filesystem is a natural interface for representing and managing the hierarchy
of classes offering several advantages: 

- direct representation of class hierarchy in the filesystem's tree structure

- does not need any new system calls using standard unix
  filesystem systemcalls instead

- intuitive mapping of filesystem/file operations such as mkdir/rmdir,
read/write and chmod etc. onto creation/deletion of classes, getting/setting
class shares, controlling permissions etc.

- easy tracking and control of permissions at any level of the hierarchy with
with read, write and access rights on a user, group and other basis.

- uses standard unix filesystem system calls instead of defining any new doesn't need any new system calls and instead uses standard unix
  filesystem one.

The root of rcfs, typically mounted as /rcfs, represents the whole system.
Each class is represented by a directory containing the following

a) "magic" files : The following are proposed
     |-- target : placeholder to identify class when moving tasks to it
     |-- shares : contains guarantees and limits of this class for each 
                  managed resource
     |-- stats  : contains usage by this class of each managed resource
     |-- config : config file for changing/reading configuration parameters
                  for rcfs as well as resource controllers
     
b) |-- members/ : Subdirectory containing symlinks to the /proc entries for
tasks belonging to the class, but not to any of its subclasses i.e. tasks
belonging to a class' default subclass as defined below.

c) Subdirectories for each subclass: each subdirectory is similar to the
parent.


rcfs configuration parameters can be set in two ways. 

a) As a mount parameter for the rcfs filesystem e.g.

	mount -t rcfs -o maxdepth=2 rcfs /rcfs   
	mount -o remount, maxdepth=2 /rcfs

b) Writing to /rcfs/config dynamically 

   echo "rcfs:<parameter name>:<parameter value>" > /rcfs/config
   e.g.  echo "rcfs:mode:manage" > /rcfs/config

The current and available config parameters can be read from /rcfs/config in
the same format as they get written.

/rcfs/config can also be used to configure resource controllers as described later.       


2.3 Default subclass
--------------------

Each class can contain tasks that do not belong to any of its subclasses. To
regulate and monitor such tasks, CKRM core implicitly defines a default
subclass for each class.

e.g. if class_A contains tasks t1,t2 and t3 and defines subclasses class_A1 which
contains t1, then t2 & t3 belong to class_A's default subclass.

The default subclass of the root of rcfs (/rcfs) is significant because it
is present at kernel bootup, being statically defined by the Core patch,
and contains, atleast initially, /sbin/init. Having such a systemwide default
class allows CKRM to ensure that every task in the system always belongs to
some class.


Default classes are not explicitly represented by a separate subdirectory at
any level of the hierarchy. Thus /rcfs/class_A/target represents both class_A and its
default subclass (moving a task to class_A implicitly moves it to the class_A's
default subclass). Default classes do have their own share and usage statistics
which are listed separately in the class' magic files 'shares' and 'stats' respectively.
User level tools can be written to display default class data explicitly.


2.4 Class creation/deletion
---------------------------

Classes are created using mkdir/rmdir at the appropriate level of the rcfs
tree. The created directory is automatically populated with the magic files and
/members subdirectory. A class is always created empty and gets populated when
tasks get manually or automatically classified to it. Removing a class is
only allowed if it has no associated tasks or subclasses in it.

2.5 Guarantees and limits
-------------------------

A guarantee is the minimum amount of resource that tasks of a class will get if
they request it. Unused portions of the guarantee can be redistributed (work
conservation) by the corresponding resource controller with a reasonably timely
reallocation back to the class, should its demand rise later.

A limit is the maximum amount of resource that a class can use. They can be
either hard or soft, depending on the capability and semantics of the resource
e.g. open file descriptor limits are always hard whereas a limit on the number
of page frames given to a class could be configured to be either hard or soft.
Classes can never consume more resources than a hard limit, regardless of the
usage by other classes. Exceeding a soft limit is permitted if the resource is
sufficiently free. Resources granted over the soft limit can be reallocated by
the resource controller to other classes which increase their demand (while
remaining under their limit). In other words, the priority of resource
allocation amongst classes is as follows

highest: classes with  demand < guarantee
	 classes with  hard/soft limit > demand > guarantee  
lowest:  classes with  demand > soft limit


Guarantees and limits are represented by whole numbers in the
/path/to/<class>/shares magic file. The calculation of a class's share is
done as follows. Each line of the /path/to/<class>/shares file represents
one managed resource and its share values in the format

   <resource name> <my_guarantee> <my_limit> <tot_guarantee> <tot_limit>

A class's guarantee/limit  =  class' <my_*> / its parent's <tot_*>
(both my_* and tot_* values corresponding to the same resource and
 * stands for 'guarantee' or 'limit')

e.g. assuming there's only entry (say cpu) in the shares file, a class
hierarchy with the following values

/A   cpu 35 60 80 90
  /a1 cpu 20 30 20 30
  /a2 cpu 5  25 5  25

will result in the following shares

a1 guarantee =  20/80, limit = 30/90
a2 guarantee =   5/80, limit = 25/90
A's default class' guarantee = (80-20-5=55)/80, limit = (90-30-25=35)/90

To derive A's share (with respect to its peer classes), a calculation similar
to the one done for a1, a2 can be done, using A's parent's <tot_*> values.

Note that the <my_*> values in /rcfs/shares have no significance (since there
are no parent <tot_*> values against which they can be interpreted). Similarly,
the <tot_*> values of a class at the leaf of the class hierarchy (i.e. one
which has no children) does not have any significance. The default subclass of
such a leaf class is guaranteed a 100% (and has a 100% limit) as long as no
other subclasses get defined.


Setting new resource shares is done through
 echo "<resource name>:[my_guarantee|my_limit....tot_limit]:<new value>" \
  > /path/to/<class>/shares

e.g	echo "cpu:tot_limit:200" > /path/to/A/shares
	changes A's total cpu limit in the example above to 200 (from 90)
        and results in changing the shares of a1, a2 and A's default classes.

while   echo "cpu:my_guarantee:45" > /path/to/A/a1/limits
	changes a1's guarantee to 45/80 (from 20/80) and reduces the guarantee
	of A's default class to (80-45-5=30)/80.


A user can determine the shares of a class by reading the
/path/to/<class>/shares file and parsing its contents as explained
above. Default subclass shares at any level can be calculated by summing the
shares listed in each of the visible subclasses shares file and subtract
the sum from the parent's tot_* value.  Userspace tools can be written to
assist with all these calculations.

Note: the reason for choosing the scheme above is to allow absolute values to
be specified while retaining the flexibility of changing all subclass shares
without requiring an atomic update to all their values. Another option
considered and abandoned was to specify relative shares only (where the tot_*
values would not be explicitly stated/modifiable but would be calculated by
summing the my_* values of all children).

<resource name> identifies the resource controller. Changes to share values
through writes and requests for shares through reads get passed on to each 
affected resource controller by the Core. As usual, unix file permissions take
care of access control to the shares file.

Each shares file need not contain entries for all managed resources. If a
resource's share is unspecified, the class's tasks are deemed to belong to the
paren'ts default class.

2.6 Gathering usage statistics
------------------------------

Statistics on resource use can be gathered from the 'stats' file in each class
directory. To make portability and scripting easier the data is in plain text.

Each stats file will have two lines for each managed resource in some format
like

	<resource name> total 
	#1 #1_unit 
	#2 #2_unit 
	#3 #3_unit
	:
	#n #n_unit
	<resource name> local 
	#1 #1_unit 
	#2 #2_unit 
	#3 #3_unit
	:
	#n #n_unit
	
where 

#n : value(number) of n'th statistic exported for <resource name> by its
     controller e.g. value of avg time using the resource, value of avg. delay
     in waiting for access to the resource 
#n_unit : units of n'th statistic in plain text e.g. ticks, ms, us, pages etc.



The statistics listed under "<resource name> local" are the values of the
resource consumption by the class's default subclass alone. It is expected to
be updated frequently by the controller.

On the other hand, the statistics listed under "<resource name> total"
correspond to the sum of statistics for the default subclass and all other
subclasses. It thus represents the total consumption for the parent
class. These values only get updated lazily at a frequency decided by each
controller individually. To get the current accurate value for total usage at a class
level, userspace tools, similar to top(1), will be provided to add up
(non-atomically) the local values of the children and parent's default subclass. 
 
Each managed resource always has an entry in the ./stats file. Thus the file
can be used to discover the managed resources in a system.

2.7 Changing a task's class
---------------------------

A task can be be classified into a class by writing its pid into the target
class' target file as follows

       echo "<pid>" > /path/to/class/target

The pid is a positive number for a normal task ID, a negative number for a
process group, similar to the sending of signals. A zero value represents the
calling task's pid.

The unix file permissions on the magic target file in the chosen class
determine whether or not the process is allowed to change into a certain task
class.  The chmod(2) system call can be used to change the permissions on who
can join a task class.

A special 'target' file is used instead of the class' directory so that
permissions to join a task class can be configured separate from permissions to
query statistics about the class.

Manual reclassification for socket accept queue control uses a parameter
different from pid as explained in Section 5.

A task can also get classified automatically if an optional Classification
Engine is present, as described in Section 4.

2.8 Monitor Mode
----------------

CKRM will support two modes of operation: monitor and manage. Manage mode is
what has been described so far with each class having guarantees and limits.

In monitor mode, a task's class is used only to track its resource usage and
not to control its resource allocation. For allocation purposes, all tasks are
considered to be in the systemwide default class and ideally, get resources
allocated just as they would in a kernel without CKRM.

Usage statistics still get collected and reported per-class as in the manage
mode. CKRM will continue to use lazy updates of the "total" statistics at each
level of the class hierarchy, as described in Section 2.6. Despite this, a
CKRM-enabled kernel in monitor mode may still incur a small performance penalty
compared to one in which CKRM is disabled.

The mode of CKRM can be set by writing "rcfs:mode:manage" or "rcfs:mode:monitor" 
into /rcfs/config.



3.0 Resource Controllers
------------------------

Resource controllers are the kernel code that enforce the class-based control
and supply the class-based statistics. They are typically implemented as
patches to the existing controllers (or schedulers) with two primary design
objectives 

- minimize impact on users not interested in class-based control
- respect shares of class hierarchy as far as possible while keeping 
code complexity and performance overheads low.

CKRM currently provides resource controllers for the primary physical resources
such as CPU (ticks), physical memory (page frames), block I/O (per-device
bandwidth) and inbound network (socket accept queues). In future, additional
controllers for virtual resources such as open files, shared memory segments
are being considered as well.

Resource controllers need to register each managed resource separately. It is
possible for one patch/module to regulate several related resources e.g. the
controller providing class-based control over open files and shared memory
segments could be the same but needs to register each of the resources
separately. 

Typically resource controllers will have private objects for each CKRM
class. The Core patch provides data structures to associate this private
data with the class objects it creates. When classes get modified (creation,
deletion, tasks moving in and out, share changes, request for usage
statistics), the Core invokes appropriate callbacks for each of the registered
resources to do the necessary changes and return data for that resource. These
callbacks and their related functions form a Core->Resource Controller API that
is internal to the kernel. 

The CKRM Core will provide helper functions for resource controllers to
traverse the class hierarchy to update statistics lazily, calculate share
values etc. The Core->RC API will be described in more detail after the User
API and high level design is finalized. http://ckrm.sf.net/ provides some idea
of what the Core->RC API will look like.

3.1 Resource controller configuration
-------------------------------------

Resource controllers can be configured by writing resource specific config
parameters to /rcfs/config in the format

	   echo "<resource name>:<param name>:<param value>" > /rcfs/config

e.g. echo "cpu:active:1" > /rcfs/config

The name and semantics of config parameters supported are resource specific and
opaque to CKRM Core. Reading /rcfs/config will list all configurable parameters
(for rcfs as a whole and each managed resource) in the same format as they are 
written.

Configuration of resource controllers can be done at any level of the /rcfs
hierarchy by writing a resource-specific configuration parameter to
/path/to/class/config e.g.

    echo "cpu:timeslice:15" > /rcfs/class_A/config

As before, the syntax and semantics of configuration parameters are determined
by the controller implementation. Controllers are always free to ignore
unsupported parameters.

4.0 Classification Engine (CE)   
------------------------------

As described briefly in Section 1, a Classification Engine is an optional
kernel module that can automatically reclassify tasks after significant kernel
events (called reclassification events) such as exec,setuid,setgid. Fork is also
a significant event with a CE callback, though it is expected that the child
will inherit its parent's class rather than be reclassified immediately.

A CE module has to register with the kernel at which time it exports a table of
callback functions, potentially one for each reclassification event. CKRM's
Core patch hooks reclassification event points in the kernel. If a CE is
present, it is queried for the class to which the task should belong after the
event. The Core then moves the task to the appropriate class. The CE callback
is also invoked so that CE can update any state it maintains as part of its
classification logic. 

At any time, only one CE can be registered with the kernel. CE's can move
between active and inactive states after registration to allow lightweight,
temporary disabling of automatic classification.

The user interface to the CE will also be through the /rcfs filesystem.  When a
CE module registers, Core creates the /rcfs/ce directory. Core provides an
interface to the CE for the latter to create magic files under /rcfs/ce. 

During registration, the CE also provides callbacks for
create/delete/read/write operations to files under /rcfs/ce. This enables the
Core and /rcfs interfaces to handle /rcfs/ce files opaquely.

/rcfs/ce is used to dynamically configure the CE including changes to the logic
it implements for reclassifying tasks. The configuration files and operations
for a typical CE such as RBCE are listed in Section 4.3.

Note: Instead of Core creating its own set of hooks into sys_fork/sys_exec etc.
the CKRM project is considering using the security_* hooks of Linux Security
Modules (LSM), that are already in the mainline 2.6 kernel. Some issues with
LSM such as stackability of its modules and availability of all necessary hooks 
are under investigation.



4.1 Manual reclassification with an active CE
---------------------------------------------

When a CE has registered and is active, tasks get automatically reclassified.
However, a sysadmin/user can override the CE by manually moving a task to a
different class under /rcfs. 

Following such a manual reclassification, the task is deemed to be outside the
CE's control. Future reclassification events affecting the task will not result
it being reclassified according to the CE's logic. The implementation of the
per-task override could be done by either marking the task so that Core does
not call the CE's reclassifier or by creating a specially tagged rule in the CE
which returns the null class (so the CE's reclassifier is called but does not
return a valid class).

A task can be put back under CE's control by writing its pid to the 
/rcfs/ce/reclassify magic file. This causes the task to get reclassified using the CE's
logic immediately as well as at all future reclassification events.

4.2 Application Tags
--------------------

The CKRM Core adds a 'tag' field to task_struct to enable applications to
assist the CE's in reclassification. 

To set/get a tasks tag field, two new system calls are introduced by CKRM:

   int sys_tsk_settag ( int pid, int len, void *tag )
   int sys_tsk_gettag ( int pid, int len, void *tag )

As before, the pid is a positive number for a normal task ID, a negative number for a
process group and zero represents the calling task's pid.


Setting a task's tag is particularly useful for relatively trusted server
applications such as databases or webservers are running on a system and doing
work on behalf of multiple classes. By setting their tag values, such applications
can tell the CE what work they are doing and the CE can map the tag to the
appropriate class.

There is some risk in allowing applications to set their tags which could result
in their being classified to classes with more resource shares. Hence a task
needs the appropriate capability to set its own share. If the application
cannot be trusted, a trusted userlevel agent could set its tag after
performing additional verification.

In all cases, the tag value is opaque to CKRM core and resource controllers.


4.3 Rule Based Classification Engine (RBCE) 
-------------------------------------------

The CKRM project will provide a general purpose CE called the Rule-Base
Classification Engine (RBCE). RBCE evaluates an ordered list of rules provided
by the user to classify tasks. Each rules is a logical and of rule terms and a
target class. Each rule term is an attribute-value pair where the attribute can
be one of several relevant members of the task_struct, including the newly
introduced tag.

RBCE defines the following files under /rcfs/ce:

1. Magic files

	|--info - read only file detailing how to setup and use RBCE.

	|--reclassify - contains nothing. Writing a pid to it reclassifies
	   the given task according to the current set of rules. Writing "all"
	   to it reclassifies all tasks in the system. This is typically done
	   by the user/sysadmin after changing/creating rules. 

        |--state - determines whether RBCE is currently active or inactive.
	   Writing 1 (0) activates (deactivates) the CE. Reading the file
	   returns the current state.
 
2. Rules subdirectory: Each rule of the RBCE is represented by a file in
   /rcfs/ce/rules. The sysadmin writes lines to the file in one of the
   following formats to define or modify a rule:

	<*id> <OP> number      where   <OP>={>,<,=}
				       <*id> = {uid,euid,gid,egid}	 

	cmd = "string" // basename of the command

	pathname = "string" // full pathname of the command

	args = "string" // argv[1] - argv[argc] of command

	apptag = "string" // application tag of the task

	[+,-]depend = rule_filename_1, rule_filename_2...

                         // used to chain a rule's terms with existing rules
			 // to avoid respecifying the latter's rule terms.
			 // A rule's dependent rules are evaluated before 
			 // its rule terms get evaluated.

			 // An optional + or - can precede the depend keyword.
			 // +depend adds a dependent rule to the tail of the
			 // current chain, -depend removes an existing 
			 // dependent rule

			 // a rulefile shows depend = none if the rule has
			 // no dependencies
			 
	order = number // order in which this rule is executed relative to 
                       // other independent rules.  
                       // rule with order 1 is checked first and so on. 
                       // As soon as a rule matches, the class of that rule 
                       // is returned to Core. So, order really matters.  
                       // If no order is specified by the user, the next 
                       // highest available order number is assigned to 
                       // the rule.


	class = "/rcfs/.../classname" // target class of this rule.
				      // /rcfs all by itself indicates the
				      // systemwide default class

        state = "number" // 1 or 0, provides the ability to deactivate a 
                         // specific rule, if needed.

	ipv4 = "string"  // ipv4 address in dotted decimal and port
                         // e.g. "127.0.0.1\80"
                         // e.g. "*\80" for CE to match any address
			 // used in socket accept queue classes (see Section 5)

        ipv6 = "string" // ipv6 address in hex and port
                        // e.g. "fe80::4567\80"
                        // e.g. "*\80" for CE to match any address 
			// used in socket accept queue classes (see Section 5)



Note: Instead of one file per rule, RBCE could use a single file to list all
rules, one per line. Given the potentially large number of terms a rule could
have, the file per rule approach may be cleaner.




5.0 Socket accept queue classes
-------------------------------

There are two types of resources that are controlled using CKRM. The first type
are system wide resources (such as CPU time) that are apportioned into
classes. Every task is assigned to a class in the system.

Another form of classification is for resources that are controlled entirely
within a process or a system object's context. For example: the socket. In a
typical setup, such as a webserver, connection requests are received from 1000s
of clients. We would like to distinguish among the requests based on the
importance of the client to the server. The client's are therefore assigned to
different classes, such as, gold/silver/bronze. The client belonging to gold
class will have its requests honoured at a higher rate (proportional to the
class's share) than one belonging to the silver or bronze class. e.g. class
gold might be the paying customers while bronze includes the 'window shoppers'.

In this section we focus on the inbound network connection control i.e. TCP
connection requests queued in the socket's accept queue.

Therefore, there are two levels of classes:

1. comprising of the listening address(es) and associated port
2. the peer's classification (done on the contents of the
   TCP SYN packet header using iptables)


Every listening socket is assigned multiple accept queues - one per
accept queue class. The connection requests are appended to these queues
depending on the class. The accept() call picks the requests from the
accept queues (classes) in accordance to the shares assigned to them.

5.1 /rcfs/network file hierarchy 
--------------------------------

The 'listening' classes are listed in /rcfs/network/socket_aq. The
'peer-classification' is controlled by "accept queue" sub-classes.

The info file specifies the default accept queue class and the number of accept
queue classes. This file is initialised by the resource controller. In the
example below the accept queues are numbered e.g. 0-7. The incoming requestes
can be MARKed 0-7 using iptable rules. The members directory lists the
ip_address/port pairs that fall under this class. There is also a symlink to
owning tasks pid.

The rest of the files such as target/shares etc. are the same for the network
classes as for any other class. The internal subclasses 0-7 do not honour moves
to target nor do they list any entries under /members.

Subclasses cannot be created below the accept_queue classes (e.g. 0-7). Nor can
one create more accept queue classes than are supported (the range is provided
in 'info' file).


/rcfs/network/sockets_aq

       |-- file info:
               - accept_q class names: 0 - 7
               - default accept_q class: 0

       |-- target
       |-- stats:    usage statistics


       /Class_A

               |-- target
               |-- shares:  1000  1000  1000  1000
               |-- stats:    usage statistics


               |-- /members
                          /<ip_address>\<port>
                                /proc/<pid>

               /1
                       |-- shares: 500 500
                       |-- stats:    usage statistics
               /2
                       |-- shares: 400 500
                       |-- stats:    usage statistics

       /Class_B
               |-- target
               |-- shares:  1000  1000  1000 1000
               |-- stats:    usage statistics


               |-- /members
                          /<ip_address>\<port>
                                /proc/<pid>

               /1
                       |-- shares: 200 500
                       |-- stats:    usage statistics
               /2
                       |-- shares: 400 500
                       |-- stats:    usage statistics
               /3
                       |-- shares: 400 500
                       |-- stats:    usage statistics



A change in the shares of a particular accept queue class (0-7) will cause the
resource controller to modify the accept queue shares in the sockets associated
with all the ipaddr\port members of the network class.

As with the process-classes the user/admin can move a listening socket to
the desired class by executing the following command:

       echo "<ip_address\port>" > /path/to/class/target




6.0 Example Control flow using CKRM
-----------------------------------

A typical usage of a CKRM-enabled system is given below: 
 
- Core is active as soon as the kernel is booted.
- resource controller 1 registers
- resource controller 2 registers
:
:
- No task is classified, resource controllers handle tasks in default mode
:
:
- User defines multiple task classes 
- User sets shares for each of the resouce classes defined
- User manually moves some tasks to some of the newly defined classes and
  these tasks get regulated according to the new shares.
:
:
- Classification engine registers
:
:
- User tells CE how to associate tasks to previously defined classes (in RBCE,
this is done by specifying rules and policies) 
- On significant kernel events (exec/setuid etc.), the affected task gets 
reclassified automatically according to the CE's rules 
- Tasks are allocated resources based on the shares of the
task class to which they belong
:
:
:
:
- User specifies iptable rules to MARK incoming TCP connections
- task calls listen() on a socket (thus specifying an ipaddress/port)
- CE returns the network/socket_aq class for the socket
- Core modifies the shares associated with the socket's acceptq classes
- incoming connections get MARKed by netfilter and are delivered to the 
  listening task in proportion of their acceptq class share
:
:
- User gets resource usage of different classes (task and network)
- User manually moves some tasks to different classes
:
- User moves all tasks out of a class and then deletes it
:
:
	
-- End --




--------------070305070304030907030608--

