Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUH3WAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUH3WAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUH3WAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:00:36 -0400
Received: from smtp1.ca.com ([141.202.248.21]:6414 "EHLO smtp1.ca.com")
	by vger.kernel.org with ESMTP id S263770AbUH3V7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:59:10 -0400
Date: Mon, 30 Aug 2004 18:06:29 -0400 (EDT)
From: Bob Bennett <Robert.Bennett2@ca.com>
To: apkm@osdl.org
cc: linux-kernel@vger.kernel.org, kgem-devel@lists.sf.net,
       robert.bennett2@ca.com
Subject: [ANNOUNCE] Kernel Generalized Event Management 
Message-ID: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Aug 2004 21:59:08.0778 (UTC) FILETIME=[934294A0:01C48EDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Respectfully submitted for evaluation and comments...

Kernel Generalized Event Management (KGEM) is an experimental facility for
collecting kernel events and managing user mode applications that are
interested in these events.  A kernel event can be anything that happens in the
kernel that an application may be interested in, such as a file being opened, a
program being executed, a process being created, etc.  KGEM provides a
structure for defining these events and delivering them to listening
applications in user space.  

Thus a user space application can listen for events in the kernel, and
potentially make an "allow or deny" decision based on evaluation of some
advanced rules or conditions.  This is useful for a security product or a
real-time scanner facility that would be included as part of an anti-virus
package.  Additionally, an application may simply collect information abour the
events that are occurring, without controlling the outcome of the events.  This
would be useful for audting or performance monitoring application.  

The idea is for KGEM to provide an API that will allow hook plugin modules 
to register kernel events, define which data elements are associated with 
the events, signal occurrence of the events to KGEM, and process responses 
from the user space applications.  A user space application can listen for
one or more events by opening a special file under the /proc filesystem 
(/proc/kgem/subscribe) and writing subscription requests.  The application 
then reads from the same file to get the event information, and writes back
to the file to provide responses.  

KGEM is available for download from http://sf.net/projects/kgem as a patch
against kernel 2.6.8.1 and as a gzipped tar file containing the source and 
documentation.  The components may be built either as kernel loadable modules
or as part of the base.

I have included a hook plugin module designed to be used with an anti-virus
realtime scanner application, whose purpose is to check files as they are 
being opened or executed, to make sure they are not infected.  This module 
defines five events; open, execve, close, fork, and exit.  It registers with
LSM to get control and generate these events.

The patch itself is too big to include in this post, but I am including the
HOWTO file here, which describes the API in more detail.

Looking forward to feedback.

Thanks in Advance,
	Bob Bennett
	Computer Associates
	Robert.Bennett2@ca.com

============================================================================
diffstats from kernel patch:

 Documentation/kgem/HOWTO         |  504 ++++++++++++++++++++++++
 Documentation/kgem/Makefile.user |   39 +
 Documentation/kgem/README        |  160 +++++++
 Documentation/kgem/gemtest.c     |  197 +++++++++
 Documentation/kgem/gemtestav.c   |  470 ++++++++++++++++++++++
 Documentation/kgem/gemtestm.c    |  317 +++++++++++++++
 Documentation/kgem/gemtestp.c    |  229 ++++++++++
 Documentation/kgem/gemtestpt.c   |  393 ++++++++++++++++++
 Makefile                         |    1 
 arch/i386/Kconfig                |    2 
 include/linux/sched.h            |    1 
 kgem/COPYING                     |  340 ++++++++++++++++
 kgem/ChangeLog                   |   41 +
 kgem/Kconfig                     |   54 ++
 kgem/Makefile                    |   30 +
 kgem/README                      |  160 +++++++
 kgem/eventdata.h                 |  147 +++++++
 kgem/gem_api.c                   |  512 ++++++++++++++++++++++++
 kgem/gem_av_events.h             |  154 +++++++
 kgem/gem_av_user.h               |   90 ++++
 kgem/gem_data.c                  |  430 ++++++++++++++++++++
 kgem/gem_data.h                  |  142 ++++++
 kgem/gem_event.c                 |  815 +++++++++++++++++++++++++++++++++++++++
 kgem/gem_event.h                 |  142 ++++++
 kgem/gem_eventfs.c               |  436 ++++++++++++++++++++
 kgem/gem_hook.c                  |  372 +++++++++++++++++
 kgem/gem_hook_av.c               |  441 +++++++++++++++++++++
 kgem/gem_hook_av_sys.c           |  661 +++++++++++++++++++++++++++++++
 kgem/gem_hook_sys.c              |  444 +++++++++++++++++++++
 kgem/gem_internal.h              |  326 +++++++++++++++
 kgem/gem_main.c                  |  336 ++++++++++++++++
 kgem/gem_status.c                |  309 ++++++++++++++
 kgem/gem_thread.c                |  148 +++++++
 kgem/gemstart                    |  106 +++++
 kgem/gemstop                     |    9 
 kgem/gemtestk.c                  |  160 +++++++
 36 files changed, 9118 insertions(+)

============================================================================
The HOWTO file:

How to use Kernel Generalized Event Management

Author: Bob Bennett, Robert.Bennett2@ca.com
	Computer Associates

Copyright 2004 Computer Associates


Introduction:
------------

Kernel Generalized Event Management (KGEM) is a facility for collecting kernel 
events and managing user mode applications that are interested in these events. 
A kernel event can be anything that happens in the kernel that an application 
may be interested in, such as a file being opened, a program being executed, 
a process being created, etc.  KGEM provides a structure for defining these 
events and delivering them to listening applications in user space.  


Organization:
------------

The heart of KGEM is a kernel loadable module that creates a directory in the 
/proc filesystem (/proc/kgem) that contains two files, 'subscribe', and 'status'
These files are used by applications in user space that wish to subscribe to
kernel events or see status information.  All interaction with user space is 
accomplished using these two procfs entries.  On the kernel side, a set of 
API calls is exported to allow events to be defined and generated.  KGEM 
itself does not have any events defined.  It only provides the infrastructure
for defining them.  

A second kernel loadable module, known as the data module, contains a set of 
functions that are used to provide data items that will be associated with an
instance of a kernel event.  These functions may only be accessed via an array
of function pointers that resides in this module, to allow easy refreshability
of this module while the system is running.  An event definition will include
a list of indices into this array, and these functions will be called to build
the event record that is given to the listening application.  

In addition to these two modules, one or more hook modules may be written to 
define the events, set the intercepts, and generate the events.  These 
modules may be written to be specific to a particular user space application 
or generalized for more wide use.  


Defining Events:
-------- ------

Events are defined by calling the gem_event_add function and passing a set
of structures that contain information about the event.  The gem_event_def 
structure is defined in gem_event.h, and looks like this:

struct gem_event_def {
        char    name[16];       /* Name of the event (must be unique) */
	int	id;		/* Event identifier */
        struct module   *owner;         /* Module that defined event */
        int     version;        /* Version of code */
        event_token_t   token;  /* Used to identify event */
        struct gem_event_def    *next;  /* Next event in list */
        struct gem_data *data;  /* List of data elements */
        int     data_num;       /* Number of elements in data */
        int     flags;          /* Characteristics of event */
}

The contents of the name field must be unique among all defined events.  
The id field must also be unique.  This is a number that can be used to 
quickly identify an event type, for the case where an application is 
listening for more than one event.  The
version field indicates the version of the event definition.  This is used
to make sure that the version of an event definition on the kernel side 
matches the version of an event that a listener is asking for.  The token is
filled in by the gem_event_add() function, and is used later to identify the
event when an instance of the event is signalled via the gem_event_call()
function.  The next field is used to chain event definitions, so that more 
than one event can be defined in a single call to gem_event_add().  The last
structure in the chain will have a next value of NULL.  The data pointer 
points to an array of gem_data structures, which defines the layout of the 
record that will be passed down to the listener.  data_num contains the number 
of elements that are in the data array.  The flags field indicates 
characteristics of the event, specifically whether it is an active or a  
passive event.  An active event is one that a listener may provide a response
for, as in the case of a security event for a file open, where a listener may
do an authorization check and potentially fail the event.  A passive event is
one in which a listener only needs to know that the event happened, and won't
want to fail it.  

The gem_data structure is defined as follows: 

struct gem_data {
        int     type;   /* Type of data */
        int     len;    /* Length of data field */
        int     idx;    /* Index of access function */
}

The type field describes the type of data, and must be one of the types 
defined in gem_data.h.  The current valid values are:

GEM_TYPE_INT		- Integer 
GEM_TYPE_CHARPTR	- Pointer to character string
GEM_TYPE_INTPTR		- Pointer to integer
GEM_TYPE_LONGPTR	- Pointer to long integer
GEM_TYPE_LONG		- Long integer

The len field is the length of the data, or in the case of a character string
pointer, the maximum length of the data.  

The idx field identifies the function that will be used to provide the data.
These are also defined in gem_data.h under 'enum data_vector_indices'.  There
are a set of special functions, named _KI_arg1 through _KI_arg10, that can be
used to get data that is supplied by the code which generates an event, that 
doesn't necessarily correspond to a standard kernel data item.  

As an example, below is the definition of the 'open' event as specified in the 
sample hook module, gem_hook.c

struct gem_data open_data[7] = {
        {GEM_TYPE_INT, sizeof(int), _KI_pid},		/* opener's pid */
        {GEM_TYPE_INT, sizeof(int), _KI_arg2},          /* open flags */
        {GEM_TYPE_INT, sizeof(int), _KI_arg3},          /* open mode */
        {GEM_TYPE_INT, sizeof(int), _KI_uid},		/* opener's uid */
        {GEM_TYPE_INT, sizeof(int), _KI_gid},		/* opener's gid */
        {GEM_TYPE_CHARPTR, 16, _KI_comm},		/* process name */
        {GEM_TYPE_CHARPTR, FNAME_MAX, _KI_arg1}         /* open fname */
};

struct gem_event_def open_event_def = {
        .name = "open",
	.id = 1,
        .owner = THIS_MODULE,
        .version = 1,
        .token = NULL,
        .next = NULL,
        .data = open_data,
        .data_num = 7,
        .flags = GEM_EVENT_ACTIVE
};

KGEM also provides two functions for removing event definitions, gem_event_del
and gem_event_del_all.  gem_event_del removes a single event definition from 
KGEM.  It takes the event token as an argument.  The gem_event_del_all function
removes all events that belong to a particular module.  It takes the module 
name as an argument.

Defining Special IOCTL Functions:
-------- ------- ----- ---------

KGEM provides the ability for a hook module to define its own IOCTL functions 
that can be called by an application that is using KGEM.  The gem_ioctl_define() 
function provides this functionality.  This function takes a pointer to an array
of gem_ioctl_def structures, each of which contains an ioctl number and a 
corresponding function pointer.   The structure definition and function 
prototype are as follows:

struct gem_ioctl_def {
	unsigned int ioctl_num;
	int (*ioctl_fn) (struct inode *, struct file*, unsigned int, 
			unsigned long);
};

int gem_ioctl_define(struct gem_ioctl_def *gem_ioctls, int numents);

'gem_ioctls' is an array of gem_ioctl_def structures, each of which contains an
ioctl command number, and a pointer to a function that will be called when that
ioctl command is sent.  Each value of 'ioctl_num' must be unique among all 
other applications that use KGEM.  If a duplicate number is provided, 
gem_ioctl_define() will return -EEXIST.  

'numents' is the number of entries in the array.

A function is also provided to remove ioctl definitions from KGEM.  The
gem_ioctl_delete() function takes the same arguments as gem_ioctl_define().


Generating Events:
---------- ------

After the events are defined to KGEM, the intercept code can signal the 
occurence of an event using the gem_event_call() function.  This function takes
a pointer to a gem_event_parm structure which contains information about the 
particular event occurrence.  This structure is defined in gem_event.h and 
looks like this:

struct gem_event_parm {
        event_token_t   token;  /* Returned by gem_event_add */
        char    *arg[10];       /* Event-specific arguments */
}

The token field is taken from the gem_event_def structure that was passed to
gem_event_add() when the event was created.  The arg pointers are general 
purpose fields that are used to pass special event-related information (such
as syscall arguments).  

When gem_event_call() is invoked, it uses the token to quickly locate the 
event definition for this particular event, and calls the functions listed 
in the gem_data array to place the contents of the fields in a buffer that 
has been allocated.  This buffer, together with other fields, comprises a
gem_event_inst structure, and represents an instance of the event.  This 
structure is queued up for the listening application to receive.  If there
are no listeners for the event, this function returns immediately.  

If an event is an active event, and the listener is an active listener, the
return code from gem_event_call() is an error code that tells the intercept
if the event should continue or be failed.  It is up to the intercept code
to fail the event using the error code returned from gem_event_call() if it 
is non-zero.

As an example, here is a code segment that shows the event call from an open 
intercept.  Here, fname, flag, and mode are the three arguments that were 
passed to the open() syscall.

	struct gem_event_parm eparm;

	if (!open_event_def.token)
                return HOOK_CONTINUE;
	eparm.token = open_event_def.token;
	eparm.arg[0] = fname;
        (int) eparm.arg[1] = flag;
        (int) eparm.arg[2] = mode;
	rc = gem_event_call(&eparm);
	return rc;

Listening for Events:
--------- --- ------

When an application in  user space wishes to listen to events that are 
defined in KGEM, it does so by first opening the file /proc/kgem/subscribe with 
flag O_RDWR.  After the file is open, a special subscription record is 
written to this file for every event that the listener is interested in.  
As soon as KGEM receives the subscription record, it will start queuing those
events for the listener.  The listener then reads from /proc/kgem/subscribe 
using the same file descriptor to retrieve the event information.  If the 
listener is listening for an active event, it must write a response record 
back to the same file descriptor before the event will continue.

At the time the event is subscribed to, it is also possible to specify 
simple selection criteria, so that we only get notified of an event if some
conditions are met, based on values returned from one or more of the data
access functions at the time of the event. 

The format of the subscription record is described by the structure 
'event_subscribe' that is defined in eventdata.h.  This structure looks like
this:

struct event_subscribe {
        int     type;           /* Identify this record as a subscribe */
        char    name[GEM_EVENT_NAME_MAX]; /* Name of event to subscribe to */
	int	idnum;		/* Number to identify event in event_rec */
        int     version;        /* version of module */
        int     flags;          /* general flags */
        int     critnum;        /* number of entries in element array */
        struct event_criteria   crit;   /* list of criteria elements */
};

Because a record written to /proc/kgem/subscribe may be either a subscription
or a event response, the type field must be set to EVENT_REC_SUBSCRIBE.  The
name field must exactly match the event name that was specified when the 
event was defined.  The application can also specify an id number that will 
be used to identify the event in the event record.  This can facilitate 
processing of event records when an application is subscribing to more than
one type of event.  The application can switch on id number rather than doing
a string compare on the event name.  The version field must also match the 
version that was specified when the event was defined.  This is a safety 
mechanism, since different versions of an event definition may have different 
event record layouts.  The flags field currently identifies whether the event 
is to be listened for actively or passively, and is set to the value 
SUB_ACTIVE_EVENT or SUB_PASSIVE_EVENT.  If SUB_ACTIVE_EVENT is set, the 
listener must write a response record back to the same file descriptor before 
the event will continue.  This is only possible if the event was defined as 
an active event.  A listener may listen passively to an event that was defined 
as active, but may not listen actively to an event that was defined as passive.  

The critnum field tells the number of entries in the selection criteria list, 
which is an array of event_data structures followed by a variable length
area which contains data to be included in the comparison for the selection.
These structures are defined in eventdata.h as follows:

struct event_data {
        int     offset; /* offset into data of criteria start. */
        int     len;    /* Length of criteria data */
        int     idx;    /* Index that identifies the data item. */
        int     type;   /* Defines the type of the data (for argx data) */
};

struct event_criteria {
        struct event_data element[MAX_SUBCRIT];
        char    data[0];
};

Each event_data element describes a data item that is to be compared with the 
corresponding data item of an event instance to determine if it should be 
delivered to the listener.  The offset field indicates the index into the 
'data[0]' array where the data begins.  The len field indicates how long the 
comparison data is.  The idx and type fields are from gem_data.h, and define
the data function that is called to get the event data, and the type of data
that is to be compared.  

When an event occurs and the listener is reading from /proc/kgem/subscribe, 
the data record that is returned on the read is a format that is a combination
of the event_rec structure and a structure whose contents are determined by 
the data array of the event definition.  The structure definition for 
event_rec looks like this:

struct event_rec {
        char    name[GEM_EVENT_NAME_MAX];       /* Name of the event */
	int	idnum;				/* Event identifier  */
        char    owner[GEM_EVENT_OWNER_MAX];     /* Owner of the event */
        struct timeval time;    /* Time that the event occurred. */
        long    seqno;          /* Sequence number of the event. */
        int     len;            /* Total length of this record   */
        char    edata[0];       /* Event specific data */
};

The owner field is filled in from the name field in the module structure of 
the kernel module that defined the event.  The time field contains the time
that the event occured.  seqno is a unique identifier that identifies the 
event to KGEM.  This is included in the response to an active event so that
KGEM knows which event instance is being responded to.  The len field gives 
the total length of this record, including the variable event specific data.
edata marks the beginning of the event specific data.

As stated before, if an application is an active listener, it must respond to
every event instance before it can continue.  The format of the response  
record is described by the event_response structure, defined in eventdata.h.
The structure is defined as follows:

struct event_response {
        int     type;   /* Identify this record as an event response */
        long    seqno;  /* Sequence number of the event (unique) */
        int     errorno; /* Error to pass back on failure or zero for pass */
        int     numalter; /* Number of data items to alter */
        struct event_data alter[MAX_RESP_ALTER];
        char    data[1];        /* Variable data section */
};

The type field identifies this record as a response, and must be set to 
EVENT_REC_RESPONSE.  seqno must match the seqno from the event_rec for which
we are responding.  The errorno field contains an error code to fail the event
with, or zero if it is not to be failed.  There is also an allowance to alter
one or more data items associated with the event, using the same mechanism 
that is used to specify selection criteria.  This feature is not yet  
implemented.

The following example code is taken from gemtesttmp.c.  It shows how the 
structure definitions are set up when listening for two events, 'open' and
'exec', and how we subscribe to receive all 'exec' events and all 'open' 
events where the filename argument starts with '/tmp', and how to fail an
event for any filename that contains the string 'bob' anywhere within the 
path name.   Note that the order and type of fields in the 'open_rec' 
structure corresponds to the order and type of fields in the previous example
of defining the 'open' event.  Note error checking and extra fluff has been
omitted for brevity's sake.

/*
 *  Event specific data for the open event.
 */
struct open_rec {
        pid_t   opid;
        int     oflag;
        int     omode;
        int     ouid;
        int     ogid;
        char    ocomm[16];
        char    ofname[FNAME_MAX];
};

/*
 *  Event specific data for the exec event.
 */
struct exec_rec {
        pid_t   opid;
        int     ouid;
        int     ogid;
        char    ocomm[16];
        char    ofname[FNAME_MAX];
};

/* 
 *  Definition of the entire record that is passed back 
 */
struct sec_rec {
        struct event_rec        e;
        union {
                struct open_rec open;
                struct exec_rec exec;
        } r;
};

/*
 *  Subscription request for open events of files that start with '/tmp'
 */

struct open_sub_struct {
        struct event_subscribe open_sub;
        char path[128];
};

enum event_id_nums {
	EVENT_OPEN,
	EVENT_EXEC
};

struct open_sub_struct open_sub_rec = {
        .open_sub = {
                .type = EVENT_REC_SUBSCRIBE,
                .name = "open",
		.idnum = EVENT_OPEN,
                .version = 1,
                .flags = SUB_ACTIVE_EVENT,
                .critnum = 1,
                .crit = {
                        .element[0] = { 0, 4 , _KI_arg1 , GEM_TYPE_CHARPTR }
                        }
        },
        .path = "/tmp"
};

/*
 *  Subscription request for all exec events
 */

struct event_subscribe exec_sub_rec = {
        .type = EVENT_REC_SUBSCRIBE,
        .name = "exec",
	.idnum = EVENT_EXEC,
        .version = 1,
        .flags = SUB_ACTIVE_EVENT,
        .critnum = 0
};

main(int argc, char **argv)
{
	int gemfile;
	int bufsize;
	char *cmpfname;
	struct sec_rec *inbuf;
	struct event_response secreply = {
		.type = EVENT_REC_RESPONSE,
		.numalter = 0
	};

	inbuf = (struct sec_rec *) malloc(sizeof(struct sec_rec));
	gemfile = open("/proc/kgem/subscribe",O_RDWR);
	bufsize = write(gemfile,&open_sub_rec,sizeof(open_sub_rec));
	bufsize = write(gemfile,&exec_sub_rec,sizeof(exec_sub_rec));
	for(;;)
	{
		bufsize = read(gemfile,inbuf,sizeof(struct sec_rec));
		if (bufsize <= 0)
			break;
		if (inbuf->e.idnum == EVENT_OPEN)
			cmpfname = inbuf->r.open.ofname;
		else
			cmpfname = inbuf->r.exec.ofname;
		if (strstr(cmpfname,"bob"))
			secreply.errorno = EACCES;
		else
			secreply.errorno = 0;
		bufsize = write(gemfile,&secreply,sizeof(secreply));
	}
	close(gemfile);
}


Listening From a Kernel Module:
------------------------------

KGEM also exports a set of functions that another kernel module can call to 
subscribe to event information.  These functions correspond to the file 
operations that can be performed by a listener in user space, with the 
exception that there are distinct subscribe and response functions rather 
than funneling both through a common write function.  There is also an option
to specify a callback function address, so that the listen code is executed
inline with the event rather than queueing data up on a read.  In the case
where callback functions are defined, it will not be necessary to use the 
read and response functions.  Following are the functions provided for 
kernel modules.   

typedef void *gem_token_t;

typedef int (*callback_t) (struct event_rec *, ssize_t);

gem_token_t gem_event_open();

int gem_event_subscribe(gem_token_t token, struct event_subscribe *subp,
                                callback_t callback_func);

ssize_t gem_event_read(gem_token_t token, struct event_rec *recp,int length);

ssize_t gem_event_response(gem_token_t token, struct event_response *resp,
                                int length);

int gem_event_release(gem_token_t token);


Showing status:
--------------

You can look at the status of KGEM by looking at the contents of the special
file /proc/kgem/status.  It currently shows the state of the facility, how 
many events have been generated, which events are defined, how many listeners
there are, and queue sizes.  Control of KGEM is currently only accomplished 
by loading and unloading the kernel modules.  You can unload any of the modules
and replace them with a new one.  If you remove a hook module, any events that
it defined will be removed and any listeners will be terminated.  
