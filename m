Return-Path: <linux-kernel-owner+w=401wt.eu-S1751800AbXAVMqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbXAVMqM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbXAVMqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:46:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:54070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbXAVMqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:46:10 -0500
X-Authenticated: #14842415
From: Alessandro Di Marco <dmr@gmx.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
References: <877ivkrv5s.fsf@gmx.it> <20070119101103.GA5730@ucw.cz>
Date: Mon, 22 Jan 2007 13:46:05 +0100
Message-ID: <877ivfi60i.fsf@gmx.it>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Pavel Machek <pavel@ucw.cz> writes:

   > +if [ ! -d "/proc/sin" ]; then
   > +    echo "/proc/sin not found, has sinmod been loaded?"
   > +    exit
   > +fi

   No new /proc files, please.

This was merely a prototype realized in a hurry, not a production
driver. Really, I did't think it could be interesting for anybody.

Would be /sys ok?

   > +cat <<EOF
   > +
   > +SIN wakes up periodically and checks for user activity occurred in the
   > +meantime; this options lets you to specify how much frequently SIN should be
   > +woken-up. Its value is expressed in tenth of seconds.

   Heh. We'll waste power trying to save it.

Well, not just a power saver. For example I use SIN to auto-logoff my bash
session as well (detaching the screen session.)

   If you have to hook it into kernel, can you at least do it properly?

Of course. You can find attached a patch fixing this. Now SIN wakes up just
when it expects to do something: if in the meantime the user interacts with the
system, SIN simply recalculates the next wake-up time on the basis of the last
user's activity date and goes to sleep again.

Best,


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=deadline.patch

---
 gentable |   72 +++++++++++++---------------------
 procfs.c |    2 +-
 sin.c    |   68 ++++++++++++++++++++------------
 sin.h    |   36 ++++++++++++++++-
 table.c  |  132 ++++++++++++++++++++++++++++----------------------------------
 table.h  |   21 +++++-----
 6 files changed, 176 insertions(+), 155 deletions(-)

diff --git a/gentable b/gentable
index 44b4f77..3a322df 100755
--- a/gentable
+++ b/gentable
@@ -31,23 +31,9 @@ fi

 cat <<EOF

-SIN wakes up periodically and checks whether user activity has occurred
-since it last ran; the next option lets you to specify how frequently
-SIN should wake up. Its value is expressed in tenth of seconds.
-
-EOF
-
-input "Pace ticks?" pace
-
-if [ -z "${pace}" ]; then
-    pace="10"
-fi
-
-cat <<EOF
-
-Asleep or not, SIN constantly monitors the input devices watching for user
-activity. The next option lets you choose which device have to be monitored.
-You must specify at least one device and must not specify duplicates.
+SIN constantly monitors the input devices watching for user activity. This
+option lets you choose which device have to be monitored. You must specify at
+least one device and must not specify duplicates.

 EOF

@@ -65,8 +51,8 @@ devices=(${devs})

 cat <<EOF

-SIN produces ACPI events depending on the user activity. You must
-specify a suitable handler that will be used as originator.
+SIN produces ACPI events depending on the user activity. You must specify a
+suitable handler that will be used as originator.

 EOF

@@ -83,18 +69,17 @@ fi
 cat <<EOF

 SIN produces events based on rules. Each rule is a triple composed by a
-"counter", a "type", and a "data" value. When SIN awakens, a global counter
-is increased if SIN detects no user activity and reset to zero, otherwise.
-When this global counter reaches the value specified in the counter field
-of a rule, an event is generated with the corresponding "type" and "data".
-Different rules should have different "type" and "data" fields to convey
-different signals to the user space daemon.
+"target", a "type", and a "data" value. The "target" field is a timeout in
+tenth of seconds specifying the minimum period of user inactivity needed to
+trigger the rule. When a rule triggers, an event is generated with the
+corresponding "type" and "data".  Different rules should have different "type"
+and "data" fields to convey different signals to the user space daemon.

-For example, the rule "60 1 19" produces the ACPI event "XXXX 00000001
-00000019" when SIN recognizes one minute of user inactivity (assuming pace=10.)
+For example, the rule "600 1 19" produces the ACPI event "XXXX 00000001
+00000019" when SIN recognizes one minute of user inactivity.

-Please specify each rule as a space-separated triple on a separate line;
-when finished, just press enter.
+Please specify each rule as a space-separated triple on a separate line; when
+finished, just press enter.

 EOF

@@ -114,9 +99,9 @@ fi

 cat <<EOF

-A special event has been provided to simplify using SIN
-as a screen-blanker. It will be generated as soon as some user activity is
-detected, but only after one or more rules have been triggered.
+A special event has been provided to simplify using SIN as a screen-blanker. It
+will be generated as soon as some user activity is detected, but only after one
+or more rules have been triggered.

 EOF

@@ -128,15 +113,14 @@ fi

 cat <<EOF

-Often an SIN event results in suspending or hibernating the system,
-hibernate, requiring user interaction to wake-up the system. Unfortunately
-that interaction occurs when SIN, as well as the kernel, cannot capture
-it. As a consequence, no event will ever be generated and
-the system will remain in the state associated with the next-to-last rule
-(e.g. blanked screen, wireless powered off, etc.). The next option
-allows you to request a special event, resetting the global
-counter to an arbitrary value, so to restart the rule-list evaluation.
-Possible value ranges are described below, where N is the maximum
+Often an SIN event results in suspending or hibernating the system, hibernate,
+requiring user interaction to wake-up the system. Unfortunately that
+interaction occurs when SIN, as well as the kernel, cannot capture it. As a
+consequence, no event will ever be generated and the system will remain in the
+state associated with the next-to-last rule (e.g. blanked screen, wireless
+powered off, etc.). The next option allows you to request a special event,
+resetting the global counter to an arbitrary value, so to restart the rule-list
+evaluation.  Possible value ranges are described below, where N is the maximum
 counter in the current rule list:

     [0, N]    => reset the global counter to the specified value
@@ -150,7 +134,7 @@ if [ -z "${reset}" ]; then
     reset="-1"
 fi

-echo -e "0\n${pace}\n${#devices[@]} ${#rules[@]}\n${devices[@]}\n${handle}\n${reset}\n${resume}" > $1
+echo -e "0\n${#devices[@]} ${#rules[@]}\n${devices[@]}\n${handle}\n${reset}\n${resume}" > $1

 for (( i = 0; ${i}<${#rules[@]}; i++ )); do
     echo "${rules[${i}]}" >> $1
@@ -163,8 +147,8 @@ All done. Now you can try your newly generated table as follows:
 # modprobe sinmod
 # echo $1 >/proc/sin/table

-An "Invalid argument" error indicates a mismatch in the table file, usually
-due to specifying an invalid acpi or input device. In that case, restart from
+An "Invalid argument" error indicates a mismatch in the table file, usually due
+to specifying an invalid acpi or input device. In that case, restart from
 scratch, double checking your inputs. Have fun!

 EOF
diff --git a/procfs.c b/procfs.c
index 4424645..5929f90 100644
--- a/procfs.c
+++ b/procfs.c
@@ -174,7 +174,7 @@ int start_procfs(void)
 		goto cleanout9;
 	}

-	interact->data = (void *) simulate_interaction;
+	interact->data = (void *) simulate_event;
 	interact->write_proc = fake_write_proc;
 	interact->owner = THIS_MODULE;

diff --git a/sin.c b/sin.c
index c490daa..0d9b9c4 100644
--- a/sin.c
+++ b/sin.c
@@ -28,18 +28,19 @@
 #include "table.h"
 #include "procfs.h"

-MODULE_AUTHOR("Alessandro Di Marco <dmr@c0nc3pt.com>");
+MODULE_AUTHOR("Alessandro Di Marco <dmr@gmx.it>");
 MODULE_DESCRIPTION("System Inactivity Notifier");
 MODULE_LICENSE("GPL v2");

-MODULE_ALIAS("blanker");
-
-MODULE_VERSION("1.2");
+MODULE_VERSION("1.3");

 static struct acpi_device *acpi_device;

-static atomic_t interactions;
-static unsigned long notify;
+static struct user_activity uact = {
+	.lock = SPIN_LOCK_UNLOCKED,
+};
+
+static unsigned long status;

 static struct timer_list timer;
 static int shutdown;
@@ -49,20 +50,31 @@ static struct input_handler ih;
 static DEFINE_MUTEX(runlock);
 static int running;

+inline unsigned long simulate_activity(void)
+{
+	return register_activity(&uact);
+}
+
 inline void signal_interaction(void)
 {
-	if (unlikely(test_and_clear_bit(0, &notify))) {
-		clear_bit(1, &notify);
+	if (unlikely(test_bit(RULE_LOCK, &status))) {
+		set_bit(RULE_MARK, &status);
+	} else if (unlikely(test_and_clear_bit(RULE_TRIG, &status))) {
+		clear_bit(RULE_WRAP, &status);
 		occasionally_generate_event(acpi_device);
 	}
 }

-static void event(struct input_handle *handle,
-		  unsigned int type, unsigned int code, int value)
+inline void simulate_event(void)
 {
 	signal_interaction();
+	(void) simulate_activity();
+}

-	atomic_inc(&interactions);
+static void event(struct input_handle *handle,
+		  unsigned int type, unsigned int code, int value)
+{
+	simulate_event();
 }

 static struct input_handle *connect(struct input_handler *handler,
@@ -90,20 +102,23 @@ static void disconnect(struct input_handle *handle)
 	kfree(handle);
 }

-void timer_fn(unsigned long pace)
+void timer_fn(unsigned long data)
 {
 	if (!shutdown) {
-		if (unlikely(test_and_clear_bit(1, &notify) &&
-			     test_and_clear_bit(0, &notify))) {
-			occasionally_generate_event(acpi_device);
-		}
+		unsigned long next;

-		timely_generate_event(acpi_device,
-				      atomic_read(&interactions), &notify);
+		set_bit(RULE_LOCK, &status);

-		atomic_set(&interactions, 0);
+		next = timely_generate_event(acpi_device,
+					     last_activity(&uact), &status);

-		timer.expires = jiffies + pace;
+		clear_bit(RULE_LOCK, &status);
+
+		if (unlikely(test_and_clear_bit(RULE_MARK, &status))) {
+			signal_interaction();
+		}
+
+		timer.expires = next;
 		add_timer(&timer);
 	}
 }
@@ -118,7 +133,7 @@ static int acpi_match(struct acpi_device *device, struct acpi_driver *driver)
 	return -ENOENT;
 }

-int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace)
+int start_monitor(char *ids, struct input_device_id *idi)
 {
 	struct acpi_driver ad = {
 		.ids = ids,
@@ -129,8 +144,7 @@ int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace)

 	mutex_lock(&runlock);

-	atomic_set(&interactions, 0);
-	notify = 0;
+	status = 0;

 	if (acpi_bus_register_driver(&ad) < 0 || !acpi_device) {
 		printk("couldn't find system ACPI device\n");
@@ -150,9 +164,11 @@ int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace)
 		return err;
 	}

-	setup_timer(&timer, timer_fn, pace);
+	setup_timer(&timer, timer_fn, 0);

-	timer.expires = jiffies + pace;
+	timer.expires =
+		timely_generate_event(acpi_device,
+				      register_activity(&uact), &status);

 	shutdown = 0;
 	add_timer(&timer);
@@ -186,7 +202,7 @@ void stop_monitor(void)

 static int __init sih_init(void)
 {
-	printk("System Inactivity Notifier 1.2 - (c) Alessandro Di Marco <dmr@c0nc3pt.com>\n");
+	printk("System Inactivity Notifier 1.3 - (c) Alessandro Di Marco <dmr@c0nc3pt.com>\n");
 	return start_procfs();
 }

diff --git a/sin.h b/sin.h
index 249021c..95161b2 100644
--- a/sin.h
+++ b/sin.h
@@ -26,9 +26,43 @@

 #define MODULE_NAME "sin"

+#define RULE_TRIG 0
+#define RULE_WRAP 1
+#define RULE_LOCK 2
+#define RULE_MARK 3
+
+struct user_activity {
+	spinlock_t lock;
+	unsigned long last;
+};
+
+static inline unsigned long register_activity(struct user_activity *uact)
+{
+	unsigned long last;
+
+	spin_lock(&uact->lock);
+	last = uact->last = jiffies;
+	spin_unlock(&uact->lock);
+
+	return last;
+}
+
+static inline unsigned long last_activity(struct user_activity *uact)
+{
+	unsigned long last;
+
+	spin_lock(&uact->lock);
+	last = uact->last;
+	spin_unlock(&uact->lock);
+
+	return last;
+}
+
+extern unsigned long simulate_activity(void);
 extern void signal_interaction(void);
+extern void simulate_event(void);

-extern int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace);
+extern int start_monitor(char *ids, struct input_device_id *idi);
 extern void stop_monitor(void);

 #endif /* SIN_H */
diff --git a/table.c b/table.c
index c9c8af6..658636f 100644
--- a/table.c
+++ b/table.c
@@ -32,7 +32,7 @@
 #include "acpi_enumerator.h"

 static struct table rt;
-static int counter, action;
+static int next_rule;

 /*
  * WARNING: sonypi, buttons and others issue a spurious event when removed from
@@ -42,67 +42,52 @@ static int counter, action;

 void occasionally_generate_event(struct acpi_device *acpi_device)
 {
-	if (unlikely(rt.debug)) {
-		printk("generating special event [%d, %d]\n",
-		       rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);
-	}
+	printd("generating special event [%d, %d]\n",
+	       rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);

 	(void) acpi_bus_generate_event(acpi_device, rt.rules[rt.rnum].type,
 				       rt.rules[rt.rnum].data);
+
+	next_rule = 0;
 }

-void timely_generate_event(struct acpi_device *acpi_device,
-			   int interactions, unsigned long *notify)
+unsigned long timely_generate_event(struct acpi_device *acpi_device,
+				    unsigned long last, unsigned long *status)
 {
-	if (interactions && counter) {
-		if (unlikely(rt.debug)) {
-			printk("user activity detected, counter reset!\n");
+	printd("last %lu [status %lu], now %lu -> next target is %lu (%d)\n",
+	       last, *status, jiffies,
+	       last + rt.rules[next_rule].target, next_rule);
+
+	for (; next_rule < rt.rnum &&
+		     time_after_eq(jiffies, last + rt.rules[next_rule].target);
+	     next_rule++) {
+		if (unlikely(test_and_clear_bit(RULE_WRAP, status))) {
+			printd("passive wrap, generating special event\n");
+
+			(void) acpi_bus_generate_event(acpi_device,
+						       rt.rules[rt.rnum].type,
+						       rt.rules[rt.rnum].data);
 		}

-		counter = action = 0;
-	}
-
-	if (unlikely(rt.debug)) {
-		printk("global counter %d, next rule is [%d %d %d]\n",
-		       counter,
-		       rt.rules[action].counter,
-		       rt.rules[action].type,
-		       rt.rules[action].data);
-	}
-
-	while (action < rt.rnum && rt.rules[action].counter == counter) {
-		if (unlikely(rt.debug)) {
-			printk("generating event [%d, %d]\n",
-			       rt.rules[action].type,
-			       rt.rules[action].data);
-		}
+		printd("generating event [%d, %d]\n",
+		       rt.rules[next_rule].type, rt.rules[next_rule].data);

 		(void) acpi_bus_generate_event(acpi_device,
-					       rt.rules[action].type,
-					       rt.rules[action].data);
-		action++;
-		set_bit(0, notify);
+					       rt.rules[next_rule].type,
+					       rt.rules[next_rule].data);
+		set_bit(RULE_TRIG, status);
 	}

-	if (rt.raction >= 0 && action == rt.rnum) {
-		if (unlikely(rt.debug)) {
-			printk("last rule reached, restarting from %d\n",
-			       rt.rcounter);
-		}
+	if (rt.rwrap >= 0 && next_rule == rt.rnum) {
+		printd("last rule reached, restarting from %d\n", rt.rwrap);

-		counter = rt.rcounter;
-		action = rt.raction;
-		set_bit(1, notify);
+		next_rule = rt.rwrap;
+		set_bit(RULE_WRAP, status);

-	} else {
-		counter++;
+		last = simulate_activity();
 	}
-}

-void simulate_interaction(void)
-{
-	signal_interaction();
-	counter = action = 0;
+	return last + rt.rules[next_rule].target;
 }

 #define parse_num(endp) ({				\
@@ -117,10 +102,11 @@ void simulate_interaction(void)

 static int cmp(const void *l, const void *r)
 {
-	int lc = ((struct rule *) l)->counter;
-	int rc = ((struct rule *) r)->counter;
+	long lt = ((struct rule *) l)->target;
+	long rt = ((struct rule *) r)->target;
+	long dd = lt - rt;

-	return lc < rc ? -1 : lc > rc ? 1 : 0;
+	return dd < 0 ? -1 : dd > 0 ? 1 : 0;
 }

 static void swap(void *l, void *r, int size)
@@ -136,6 +122,7 @@ int push_table(char *buf, unsigned long count)
 	struct table nrt;
 	struct input_device_id *idi;
 	struct uniq uniq;
+
 	int devices;

 	int i, err = -ENOMEM;
@@ -144,12 +131,15 @@ int push_table(char *buf, unsigned long count)

 	nrt.debug = parse_num(buf);

-	nrt.pace = (parse_num(buf) * HZ) / 10;
 	nrt.dnum = parse_num(buf);
 	nrt.rnum = parse_num(buf);

-	if (out_of_range(1, nrt.pace, 1000000) ||
-	    out_of_range(0, nrt.dnum, devices)) {
+	if (out_of_range(0, nrt.dnum, devices)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (nrt.rnum <= 0) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -188,36 +178,32 @@ int push_table(char *buf, unsigned long count)
 		goto cleanout2;
 	}

-	nrt.rcounter = parse_num(buf);
+	nrt.rwrap = parse_num(buf);
+	if (out_of_range(0, nrt.rwrap, nrt.rnum)) {
+		err = -EINVAL;
+		goto cleanout2;
+	}

-	nrt.rules[nrt.rnum].counter = -1;
+	nrt.rules[nrt.rnum].target = MAX_JIFFY_OFFSET;
 	nrt.rules[nrt.rnum].type = parse_num(buf);
 	nrt.rules[nrt.rnum].data = parse_num(buf);

 	for (i = 0; i < nrt.rnum; i++) {
-		nrt.rules[i].counter = parse_num(buf);
-		if (nrt.rules[i].counter < 0) {
+		unsigned int msecs;
+
+		msecs = 100 * parse_num(buf);
+		if (out_of_range(0, msecs, 172800000 /* 48 hrs */)) {
 			err = -EINVAL;
 			goto cleanout2;
 		}

+		nrt.rules[i].target = msecs_to_jiffies(msecs);
 		nrt.rules[i].type = parse_num(buf);
 		nrt.rules[i].data = parse_num(buf);
 	}

 	sort(nrt.rules, nrt.rnum, sizeof (struct rule), cmp, swap);

-	nrt.raction = -1;
-
-	if (nrt.rcounter >= 0) {
-		for (i = 0; i < nrt.rnum; i++) {
-			if (nrt.rules[i].counter >= nrt.rcounter) {
-				nrt.raction = i;
-				break;
-			}
-		}
-	}
-
 	if (!tablecmp(&rt, &nrt)) {
 		err = count;
 		goto cleanout2;
@@ -237,7 +223,7 @@ int push_table(char *buf, unsigned long count)

 	memcpy(&rt, &nrt, sizeof (struct table));

-	err = start_monitor(get_hardware_id(rt.handle), idi, nrt.pace);
+	err = start_monitor(get_hardware_id(rt.handle), idi);
 	if (err < 0) {
 		goto cleanout3;
 	}
@@ -264,8 +250,7 @@ int pull_table(char **buf)
 		return -EFAULT;
 	}

-	b += sprintf(b, "%d\n%lu\n%d %d\n", rt.debug,
-		     (rt.pace * 10) / HZ, rt.dnum, rt.rnum);
+	b += sprintf(b, "%d\n%d %d\n", rt.debug, rt.dnum, rt.rnum);

 	for (i = 0; i < rt.dnum; i++) {
 		b += sprintf(b, "%d ", rt.devices[i]);
@@ -274,11 +259,12 @@ int pull_table(char **buf)
 	b--;

 	b += sprintf(b, "\n%d\n%d\n%d %d\n",
-		     rt.handle, rt.rcounter,
+		     rt.handle, rt.rwrap,
 		     rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);

 	for (i = 0; i < rt.rnum; i++) {
-		b += sprintf(b, "%d %d %d\n", rt.rules[i].counter,
+		b += sprintf(b, "%d %d %d\n",
+			     jiffies_to_msecs(rt.rules[i].target) / 100,
 			     rt.rules[i].type, rt.rules[i].data);
 	}

@@ -291,5 +277,5 @@ void cleanup_table(void)
 	kfree(rt.rules);
 	memset(&rt, 0, sizeof (struct table));

-	counter = action = 0;
+	next_rule = 0;
 }
diff --git a/table.h b/table.h
index 413b8eb..71b19d2 100644
--- a/table.h
+++ b/table.h
@@ -25,29 +25,32 @@
 #include <acpi/acpi_bus.h>

 struct rule {
-	int counter;
+	unsigned long target; /* jiffies */
 	int type;
 	int data;
 };

 struct table {
 	int debug;
-	unsigned long pace;
 	int dnum, rnum;
 	int *devices;
 	int handle;
-	int rcounter, raction;
+	int rwrap;
 	struct rule *rules;
 };

+#define printd(fmt...)				\
+	if (unlikely(rt.debug)) {		\
+		printk(fmt);			\
+	}
+
 static inline int tablecmp(struct table *l, struct table *r)
 {
 	if (l->debug != r->debug ||
-	    l->pace != r->pace ||
 	    l->dnum != r->dnum ||
+	    l->rnum != r->rnum ||
 	    l->handle != r->handle ||
-	    l->rcounter != r->rcounter ||
-	    l->raction != r->raction) {
+	    l->rwrap != r->rwrap) {
 		return 1;
 	}

@@ -66,12 +69,10 @@ static inline int tablecmp(struct table *l, struct table *r)
 		    + rt.dnum * sizeof (int)			  \
 		    + rt.rnum * sizeof (struct rule))

-#define TABLE_BUFFER_SIZE (9 + rt.dnum + rt.rnum * 3 + (TABLE_SIZE << 3) / 3)
+#define TABLE_BUFFER_SIZE (8 + rt.dnum + rt.rnum * 3 + (TABLE_SIZE << 3) / 3)

 extern void occasionally_generate_event(struct acpi_device *acpi_device);
-extern void timely_generate_event(struct acpi_device *acpi_device, int interactions, unsigned long *notify);
-
-void simulate_interaction(void);
+extern unsigned long timely_generate_event(struct acpi_device *acpi_device, unsigned long last, unsigned long *notify);

 extern int push_table(char *buf, unsigned long count);
 extern int pull_table(char **buf);
--
1.4.4.4


--=-=-=


-- 
Of one thing I am certain, the body is not the measure of healing - peace is
the measure. - George Melton

--=-=-=--
